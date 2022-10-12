class Public::ScoresController < ApplicationController
  before_action :authenticate_user!

  def create
    # score_sheet = current_user.score_sheets.find(params[:id])
    @score_form = Form::ScoreCollection.new(score_collection_params)
    if @score_form.save
      redirect_to edit_score_sheet_path(params[:id])
    else
      flash[:alert] = "スコアの入力フォームに空欄があります。"
      @score_sheet = current_user.score_sheets.find(params[:id])
      # 「Form::ScoreCollection」についてはmodels/form/score_collection.rb内に詳しく記述しました。
      @score_form = Form::ScoreCollection.new
      # 1つのscore_sheetの中に4つのsheetが同時に作成される。そこから各プレイヤーのIDを割り出しインスタンスに収納している。
      @player1 = @score_sheet.sheets.order(created_at: :desc).take(1).map(&:player_id)
      @player2 = @score_sheet.sheets.order(created_at: :desc).take(2).drop(1).map(&:player_id)
      @player3 = @score_sheet.sheets.order(created_at: :desc).take(3).drop(2).map(&:player_id)
      @player4 = @score_sheet.sheets.order(created_at: :desc).drop(3).map(&:player_id)
      render "public/score_sheets/edit"
    end
  end

  def update
    score = Score.find(params[:id])
    score.update(score_params)
    redirect_to edit_score_sheet_path(params[:score][:score_sheet_id])
  end


  private
    # models/form/score_collection.rbを利用しScoreモデルに指定のパラメータだけ送りたいので、scores_attributes内に５つのカラムを記述。
    def score_collection_params
      params.require(:form_score_collection).permit(scores_attributes: [:score_sheet_id, :player_id, :tip, :point, :rank])
    end

    def score_params
      params.require(:score).permit(:rank, :tip, :point)
    end
end
