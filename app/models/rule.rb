class Rule < ApplicationRecord
  belongs_to :user
  has_many :score_sheets

  validates :name, presence: true
  validates :tip_point, presence: true
  validates :table_point, presence: true
  validates :calculation_status, presence: true

  # enumを使用。「/mahjong_club/config/locales/ja.yml」に各日本語を記述してあります。
  enum calculation_status: { nothing: 0, subtraction_evenness: 1, subtraction_top: 2, subtraction_bottom: 3 }
end
