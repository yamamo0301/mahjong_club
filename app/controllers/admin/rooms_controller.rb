class Admin::RoomsController < ApplicationController
  before_action :move_to_admin_signed_in

  def show
    @room = Room.find(params[:id])
    @user = User.find(params[:user_id])
    @messages = @room.messages.all
    @message = Message.new
    # @entriesと@another_entryでview側に相手の名前を表示。
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: @user.id).first
  end


  private

  def move_to_admin_signed_in
    unless admin_signed_in?
      redirect_to  '/admin/sign_in'
    end
  end
end
