class Public::ScoresController < ApplicationController
  before_action :authenticate_user!

  def create
    @score_form = Form::ScoreCollection.new(score_collection_params)
    @score_form.save
    redirect_to edit_score_sheet_path(params[:id])
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
