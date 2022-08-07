class CreateRules < ActiveRecord::Migration[6.1]
  def change
    create_table :rules do |t|
      t.string "name", null: false
      t.integer "tip_point", null: false, default: 0
      t.integer "table_point", null: false, default: 0
      t.integer "calculation_status", null: false, default: 0

      t.timestamps
    end
  end
end
