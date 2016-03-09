class CreateThrows < ActiveRecord::Migration
  def change
    create_table :throws do |t|
      t.integer :player_number
      t.integer :frame_number
      t.integer :throw_number
      t.binary :pins_down, limit: 10, default: 0000000000
      t.references :game, new: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
