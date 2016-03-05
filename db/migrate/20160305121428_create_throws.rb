class CreateThrows < ActiveRecord::Migration
  def change
    create_table :throws do |t|
      t.binary :pins_down, limit: 10, default: 0000000000
      t.references :frame, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
