class CreateScoreSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :score_sheets do |t|
      t.integer "rule_id", null: false
      t.integer "user_id", null: false
      t.text    "comment"

      t.timestamps
    end
  end
end
