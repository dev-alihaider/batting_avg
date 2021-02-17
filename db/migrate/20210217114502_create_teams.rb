class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :team_id

      t.timestamps
    end
    add_index :teams, :team_id, unique: true
  end
end
