class Public::ScoreSheetsController < ApplicationController
  def new
    @score_sheet = current_user.score_sheets.new
    @sheet_form = Form::SheetCollection.new
  end

  def index
    @score_sheets = current_user.score_sheets.all
  end

  def show
    @score_sheet = current_user.score_sheets.find(params[:id])
  end

  def create
    @score_sheet = current_user.score_sheets.new(score_sheet_params)
    @sheet_form = Form::SheetCollection.new(sheet_collection_params)
    @score_sheet.save
    @sheet_form.save(@score_sheet)
    redirect_to edit_score_sheet_path(@score_sheet)
  end

  def edit
    @score_sheet = current_user.score_sheets.find(params[:id])
    @score_form = Form::ScoreCollection.new
  end

  def destroy
    score_sheet = current_user.score_sheets.find(params[:id])
    score_sheet.destroy
    redirect_to score_sheets_path
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
