class Admin::RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @user = User.find(params[:user_id])
    @messages = @room.messages.all
    @message = Message.new
    # @entriesと@another_entryでview側に相手の名前を表示。
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: @user.id).first
  end
end
