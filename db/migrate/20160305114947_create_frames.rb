class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :number
      t.references :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
