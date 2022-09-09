class Admin::UsersController < ApplicationController
  before_action :move_to_admin_signed_in

  def show
    @user = User.find(params[:id])
    # ログインユーザー所属ルームID取得
    # ログインユーザーがやりとりしているroomのIDをすべて取得しそれを配列化してmy_room_idとしている。
    current_entries = @user.entries
    # 空の配列を渡してあげる。
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    # 自分のroom_idでuser_idが自分では無いものを取得。
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: @user.id)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
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
    params.require(:user).permit(:is_deleted)
  end


  protected

  def move_to_admin_signed_in
    unless admin_signed_in?
      redirect_to  '/admin/sign_in'
    end
  end

end