class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets do |t|
      t.integer "score_sheet_id", null: false
      t.integer "player_id",      null: false

      t.timestamps
    end
  end
end
