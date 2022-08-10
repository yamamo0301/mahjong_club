class Public::ScoreSheetsController < ApplicationController
  def new
    @score_sheet = current_user.score_sheets.new
    @sheet_form = Form::SheetCollection.new
  end

  def create
    @score_sheet = current_user.score_sheets.new(score_sheet_params)
    @sheet_form = Form::SheetCollection.new(sheet_collection_params)
    @score_sheet.save
    @sheet_form.save(@score_sheet)
    redirect_to edit_score_sheet_path(@score_sheet)
  end


  private

  def score_sheet_params
    params.require(:form_sheet_collection).permit(
      :rule_id,
      form_sheet_collection_attributes: :player_id)
  end

  def sheet_collection_params
    params
      .require(:form_sheet_collection)
      .permit(sheets_attributes: :player_id)
  end
end
