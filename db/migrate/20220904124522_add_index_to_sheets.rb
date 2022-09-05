class AddIndexToSheets < ActiveRecord::Migration[6.1]
  def change
    add_index :sheets, [:score_sheet_id, :player_id], unique: true
  end
end
