class ScoreSheet < ApplicationRecord
  belongs_to :user
  belongs_to :rule
  has_many :sheets, dependent: :destroy
  has_many :scores, dependent: :destroy
end
