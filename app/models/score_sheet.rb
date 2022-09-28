class ScoreSheet < ApplicationRecord
  belongs_to :user
  belongs_to :rule
  has_many :sheets, dependent: :destroy
  has_many :scores, dependent: :destroy

  validates :rule_id, presence: true

  # ruleで選択した計算方法を行うためのメソッド。
  def table_point_calculation(player)
    if rule.calculation_status == "subtraction_evenness"
      "TP #{scores.where(player_id: player).size * -(rule.table_point)}P"
    elsif rule.calculation_status == "subtraction_top"
      "TP #{scores.where(player_id: player, rank: 1).size * -(rule.table_point)}P"
    elsif rule.calculation_status == "subtraction_bottom"
      "TP #{scores.where(player_id: player, rank: 4).size * -(rule.table_point)}P"
    else
      "TP0P"
    end
  end

  # HTML上でscoreの合計値を表示させるためのメソッド。
  def total_point(player)
    scores.where(player_id: player).sum(:tip) * rule.tip_point + scores.where(player_id: player).sum(:point)
  end

end
