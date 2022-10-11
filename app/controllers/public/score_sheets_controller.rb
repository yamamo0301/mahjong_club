class Public::ScoreSheetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @score_sheet = current_user.score_sheets.new
    @sheet_form = Form::SheetCollection.new
  end

  def index
    @score_sheets = current_user.score_sheets.order("id DESC")
  end

  def show
    @score_sheet = current_user.score_sheets.find(params[:id])
    # 1つのscore_sheetの中に4つのsheetが同時に作成される。そこから各プレイヤーのIDを割り出しインスタンスに収納している。
    @player1 = @score_sheet.sheets.order(created_at: :desc).take(1).map(&:player_id)
    @player2 = @score_sheet.sheets.order(created_at: :desc).take(2).drop(1).map(&:player_id)
    @player3 = @score_sheet.sheets.order(created_at: :desc).take(3).drop(2).map(&:player_id)
    @player4 = @score_sheet.sheets.order(created_at: :desc).drop(3).map(&:player_id)
  end

  def create
    @score_sheet = current_user.score_sheets.new(score_sheet_params)
    # 「Form::SheetCollection」についてはmodels/form/sheet_collection.rb内に詳しく記述しました。
    @sheet_form = Form::SheetCollection.new(sheet_collection_params)
    # ScoreSheetモデルにレコードを作成すると同時にSheetモデルにもレコードを作成するためsaveメソッドがtrueではない場合ロールバックする。
    ScoreSheet.transaction do
      @score_sheet.save!
      @sheet_form.save(@score_sheet)
    end
    redirect_to edit_score_sheet_path(@score_sheet)
    # @score_sheet.save!を使用しているためtrueではない場合rescueでキャッチ。
    rescue => e
      flash[:alert] = "スコアシート作成に失敗しました。"
      render :new
  end

  def edit
    @score_sheet = current_user.score_sheets.find(params[:id])
    # 「Form::ScoreCollection」についてはmodels/form/score_collection.rb内に詳しく記述しました。
    @score_form = Form::ScoreCollection.new
    # 1つのscore_sheetの中に4つのsheetが同時に作成される。そこから各プレイヤーのIDを割り出しインスタンスに収納している。
    @player1 = @score_sheet.sheets.order(created_at: :desc).take(1).map(&:player_id)
    @player2 = @score_sheet.sheets.order(created_at: :desc).take(2).drop(1).map(&:player_id)
    @player3 = @score_sheet.sheets.order(created_at: :desc).take(3).drop(2).map(&:player_id)
    @player4 = @score_sheet.sheets.order(created_at: :desc).drop(3).map(&:player_id)
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
      # Viewでfields_forを使用してform_sheet_collectionにパラメータを送るため。
      params.require(:form_sheet_collection).permit(
        :rule_id,
        form_sheet_collection_attributes: :player_id)
    end

    def score_sheet_update_params
      params.require(:score_sheet).permit(:rule_id, :comment)
    end

    def sheet_collection_params
      # models/form/sheet_collection.rbを利用しSheetモデルにplayer_idのパラメータだけ送りたいので、sheets_attributes内にplayer_idを記述。
      params.require(:form_sheet_collection).permit(sheets_attributes: :player_id)
    end
end
