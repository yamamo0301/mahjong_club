class Form::ScoreCollection < Form::Base
  FORM_COUNT = 1
  attr_accessor :scores

  def initialize(attributes = {})
    super attributes
    self.scores = FORM_COUNT.times.map { Score.new() } unless self.scores.present?
  end

  def scores_attributes=(attributes)
    self.scores = attributes.map { |_, v| Score.new(v) }
  end

  def save
    Score.transaction do
      self.scores.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end