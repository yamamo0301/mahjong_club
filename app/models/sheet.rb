class Sheet < ApplicationRecord
  belongs_to :player
  belongs_to :score_sheet

  validates :score_sheet_id, uniqueness: {scope: :player_id}
end
