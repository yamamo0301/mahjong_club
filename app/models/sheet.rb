class Sheet < ApplicationRecord
  belongs_to :player
  belongs_to :score_sheet
end
