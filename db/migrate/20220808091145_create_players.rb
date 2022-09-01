class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.integer :user_id,      null: false
      t.string  :name,         null: false
      t.boolean :myself_status,   null: false, default: false

      t.timestamps
    end
  end
end
