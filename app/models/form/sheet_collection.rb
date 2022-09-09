class Form::SheetCollection < Form::Base
  FORM_COUNT = 4
  # クラス外部からインスタンス変数への読み書きを可能にするために記述。
  attr_accessor :sheets

  # sheets_collection_paramsがnilだった場合困るので、「= {}」として初期化。
  # sheets_collection_paramsに値が入っていた場合は、「= {}」は無視される。
  def initialize(attributes = {})
    super attributes
    # FORM_COUNTが持つ数値から順に-1しつつ配列に代入しSheet.newを与えてあげる。（self = Form::SheetCollection）
    # unless~present?を使用して値が存在する場合はfalseを返してあげる。（Form::SheetCollection.new(…)としたい為）
    self.sheets = FORM_COUNT.times.map { Sheet.new() } unless self.sheets.present?
  end

  # 上でsuper attributesとしているので必要。
  def sheets_attributes=(attributes)
    # 配列においてキーの値をSheet.newに引数として渡す。
    self.sheets = attributes.map { |_, v| Sheet.new(v) }
  end

  def save(score_sheet)
    # transaction do以降の処理の中１つが失敗した場合、SQL処理を全部ロールバックするためにtransactionを使用。
    Sheet.transaction do
      # sheets内の配列１つ１つにscore_sheet_idを渡していく。
      self.sheets.each { |sheet| sheet.score_sheet_id = score_sheet.id }
      # sheets内の配列１つ１つに渡されていた値をsave!していく。
      self.sheets.map(&:save!)
    end
      return true
    # save!を使用したためtrueではない場合recue節へ。
    # ActiveRecord::RecordInvalidオブジェクトをeへ。
    rescue => e
      return false
  end
end