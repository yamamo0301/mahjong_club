class Sheet < ApplicationRecord
  belongs_to :player
  belongs_to :score_sheet

  # 1つのscore_sheet内で同じplayer_idが存在しないように一意性を付与。（DB側に「add_index ~ unique: true」を追加）
  validates :score_sheet_id, uniqueness: {scope: :player_id}
end
