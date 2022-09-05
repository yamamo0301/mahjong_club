class Player < ApplicationRecord
  belongs_to :user
  has_many :scores
  has_many :sheets

  validates :name, presence: true
end
