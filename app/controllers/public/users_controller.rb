class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @my_user = @user.players.find(1).scores.order("id DESC")
    rank1 = @my_user.where(rank: 1).size
    rank2 = @my_user.where(rank: 2).size
    rank3 = @my_user.where(rank: 3).size
    rank4 = @my_user.where(rank: 4).size
    @ranks_array = [rank1, rank2, rank3, rank4]

    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    # unlessでログインしていないユーザーという条件をつける。
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          # 同じroom_idが存在する場合は既にroomが存在しているということなのでroom_idの変数とroomが存在するかどうかの条件であるis_roomを渡す。
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      # 同じroom_idが存在しない場合は新しくインスタンスを作成します。
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def search
    if params[:prefecture_id].present?
      @users = User.where(prefecture_id: params[:prefecture_id])
    else
      @users = User.none
    end
  end


  private

  def user_params
    params.require(:user).permit(:icon)
  end

end
