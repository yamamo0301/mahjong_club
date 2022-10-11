class Form::SheetCollection < Form::Base
  FORM_COUNT = 4
  # クラス外部からインスタンス変数への読み書きを可能にするために記述。
  attr_accessor :sheets

  # sheets_collection_paramsがnilだった場合困るので、「= {}」として初期化。
  # sheets_collection_paramsに値が入っていた場合は、「= {}」は無視される。
  def initialize(attributes = {})
    super attributes
    # unless~present?を使用してattributesのオブジェクト内に値が存在場合はfalseを返すあげる。（Form::SheetCollection.new(…)としたい為）
    # FORM_COUNTが持つ数値から順に-1しつつ配列に代入しSheet.newを与えてあげる。（self = Form::SheetCollection）
    self.sheets = FORM_COUNT.times.map { Sheet.new() } unless self.sheets.present?
  end

  # 上でsuper attributesとしているのでinitializeの処理が行われる。
  def sheets_attributes=(attributes)
    # 配列においてキーの値をSheet.newに引数として渡す。
    self.sheets = attributes.map { |_, v| Sheet.new(v) }
  end

  def save(score_sheet)
    # transaction do以降の処理の中１つが失敗した場合、SQL処理を全部ロールバックするためにtransactionを使用。
    Sheet.transaction do
      self.sheets.each do |sheet|
        # sheet内のplayer_idがnilでなければRollbackされる。
        raise ActiveRecordRollback if sheet.player_id == nil
        # sheets内の配列１つ１つにscore_sheet_idを渡していく。
        sheet.score_sheet_id = score_sheet.id
      end
      # sheets内の配列１つ１つに渡されていた値をsave!していく。
      self.sheets.map(&:save!)
    end
    true
    # save!を使用した為trueではない場合recue節となるが、コントローラー内でtransactionを使用している。なのでrescueで例外をキャッチしてしまうとロールバックしない。
    # rescue => e
    # return false
  end
end
