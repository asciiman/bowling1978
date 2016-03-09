class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_count
      t.timestamps null: false
    end
  end
end
