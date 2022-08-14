class Public::ScoresController < ApplicationController
  def create
    @score_form = Form::ScoreCollection.new(score_collection_params)
    @score_form.save
    redirect_to edit_score_sheet_path(params[:id])
  end


  private

  def score_collection_params
    params
      .require(:form_score_collection)
      .permit(scores_attributes: [:score_sheet_id, :player_id, :tip, :point, :rank] )
  end
end
