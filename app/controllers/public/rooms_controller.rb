class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    # show.html.erbで部屋が存在しなかった場合にformで送られてきたパラメーターが来る。
    # 現在ログインしているユーザーとメッセージ相手のユーザーそれぞれの情報をroom_idで紐付けてEntryテーブルにcreate。
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:room][:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def index
    # ログインユーザー所属ルームID取得
    # ログインユーザーがやりとりしているroomのIDをすべて取得しそれを配列化してmy_room_idとしている。
    current_entries = current_user.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    # 自分のroom_idでuser_idが自分じゃないのを取得
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    # @entriesと@another_entryでview側に相手の名前を表示。
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end
end
