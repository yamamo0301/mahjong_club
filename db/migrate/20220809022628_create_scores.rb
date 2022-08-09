class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer "score_sheet_id", null: false
      t.integer "player_id",      null: false
      t.integer "point",          null: false, default: 0
      t.integer "tip",            null: false, default: 0
      t.integer "rank",           null: false

      t.timestamps
    end
  end
end
