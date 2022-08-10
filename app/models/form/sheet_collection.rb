class Form::SheetCollection < Form::Base
  FORM_COUNT = 4
  attr_accessor :sheets

  def initialize(attributes = {})
    super attributes
    self.sheets = FORM_COUNT.times.map { Sheet.new() } unless self.sheets.present?
  end

  def sheets_attributes=(attributes)
    self.sheets = attributes.map { |_, v| Sheet.new(v) }
  end

  def save(score_sheet)
    Sheet.transaction do
      self.sheets.each { |sheet| sheet.score_sheet_id = score_sheet.id }
      self.sheets.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end