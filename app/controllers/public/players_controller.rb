class Public::PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @players = current_user.players.where.not(myself_status: true)
    @player = current_user.players.new
  end

  def create
    @player = current_user.players.new(player_params)
    if @player.save
      flash[:notice] = '新しいプレイヤーを追加しました。'
      redirect_to players_path
    else
      render :index
    end
  end

  def edit
    @players = current_user.players.where.not(myself_status: true)
    @player = current_user.players.find(params[:id])
  end

  def update
    @player = current_user.players.find(params[:id])
    if @player.update(player_params)
      flash[:notice] = 'プレイヤー名を更新しました。'
      redirect_to players_path
    else
      render :edit
    end
  end


  private

  def player_params
    params.require(:player).permit(:name)
  end
end
