class Score < ApplicationRecord
  belongs_to :player
  belongs_to :score_sheet
  # 親モデルに紐づくレコードを作成したいために「accepts_nested_attributes_for」を記述。
  # 「reject_if: :all_blank」を指定し該当フォームがすべて空の場合にvalidationを無効。
  accepts_nested_attributes_for :score_sheet, reject_if: :all_blank, allow_destroy: true
end
