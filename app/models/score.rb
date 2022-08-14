class Score < ApplicationRecord
  belongs_to :player
  belongs_to :score_sheet
  accepts_nested_attributes_for :score_sheet, reject_if: :all_blank, allow_destroy: true
end
