class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :player_id
      t.integer :year_id
      t.integer :stint
      t.string :team_id
      t.integer :at_bat
      t.integer :hits

      t.timestamps
    end
  end
end
