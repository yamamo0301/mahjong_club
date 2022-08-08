class Rule < ApplicationRecord
  belongs_to :user
  has_many :score_sheets
  
  enum calculation_status: { nothing: 0, subtraction_evenness: 1, subtraction_top: 2, subtraction_bottom: 3 }
end
