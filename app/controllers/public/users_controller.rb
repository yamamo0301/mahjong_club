class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # ユーザー作成時に同時に作成されたユーザー自身のプレイヤーに関連付けられたScoreモデルにレコードがある場合グラフなどを表示させるための記述。
    unless @user.players.find_by(myself_status: true).scores.empty?
      @my_user = @user.players.find_by(myself_status: true).scores.order("id DESC")
      # Chart.jsの円グラフで順位の比率を表示するために配列を渡す。
      rank1 = @my_user.where(rank: 1).size
      rank2 = @my_user.where(rank: 2).size
      rank3 = @my_user.where(rank: 3).size
      rank4 = @my_user.where(rank: 4).size
      @ranks_array = [rank1, rank2, rank3, rank4]
      # 何回対局を行ってきたのか表示させるためにscoreレコードがいくつあるのか数えるインスタンス。
      @total_game = @user.players.find_by(myself_status: true).scores.size
      # 平均順位を小数第２桁まで計算し表示するためのインスタンス。
      @average_rank = @user.players.find_by(myself_status: true).scores.average(:rank).round(2)

      @total_point = @user.players.find_by(myself_status: true).scores.sum(:point)
      @rank1_rate = rank1 * 100 / @my_user.size.to_f
      @rank2_rate = rank2 * 100 / @my_user.size.to_f
      @rank3_rate = rank3 * 100 / @my_user.size.to_f
      @rank4_rate = rank4 * 100 / @my_user.size.to_f
    end
    # それぞれの変数にEntryモデル内からログインしているユーザーのレコードと@userのレコードを配列で渡す。
    current_entry = Entry.where(user_id: current_user.id)
    another_entry = Entry.where(user_id: @user.id)
    # unlessで「@userは現在ログインしているuser_idではない」という条件をつける。
    unless @user.id == current_user.id
      # ２つの配列を各変数に格納。
      current_entry.each do |current|
        another_entry.each do |another|
          # 同じroom_idが存在する場合は既にroomが存在しているということなのでroom_idの変数とroomが存在するかどうかの条件であるis_roomを渡す。
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      # 同じroom_idが存在しない場合は新しく２つのインスタンスを作成します。
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  # 退会確認ページ
  def unsubscribe
  end

  # user.is_deletedをtrueにすることで退会している状態に変更。その後サインアウト。
  def withdraw
    @withdraw = current_user
    @withdraw.update(is_deleted: true)
    sign_out(:user)
    redirect_to root_path
  end

  # 都道府県（prefecture_id）を選択することでuserを絞り込んでいる。
  def search
    if params[:prefecture_id].present?
      @users = User.where(prefecture_id: params[:prefecture_id])
    else
      @users = User.none
    end
  end


  private

  def user_params
    params.require(:user).permit(
      :icon,
      :name,
      :prefecture_id,
      :municipality,
      :email,
      :introduction
      )
  end

end
