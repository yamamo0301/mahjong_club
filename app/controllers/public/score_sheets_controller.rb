class Public::ScoreSheetsController < ApplicationController
  def new
    @score_sheet = current_user.score_sheets.new
    @sheet_form = Form::SheetCollection.new
  end

  def index
    @score_sheets = current_user.score_sheets.order("id DESC")
  end

  def show
    @score_sheet = current_user.score_sheets.find(params[:id])
    @player1 = @score_sheet.sheets.take(1).map(&:player_id)
    @player2 = @score_sheet.sheets.take(2).drop(1).map(&:player_id)
    @player3 = @score_sheet.sheets.take(3).drop(2).map(&:player_id)
    @player4 = @score_sheet.sheets.drop(3).map(&:player_id)
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

  def update
    score_sheet = current_user.score_sheets.find(params[:id])
    score_sheet.update(score_sheet_update_params)
    redirect_to score_sheet_path(score_sheet.id)
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

  def score_sheet_update_params
    params.require(:score_sheet).permit(
      :rule_id,
      :comment)
  end

  def sheet_collection_params
    params
      .require(:form_sheet_collection)
      .permit(sheets_attributes: :player_id)
  end
end
