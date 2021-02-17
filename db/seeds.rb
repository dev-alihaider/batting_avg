# Create unique teams from csv file
require 'csv'
teams = []
CSV.foreach(Rails.root.join('lib/teams.csv'), headers: true) do |row|
  teams << Team.new({
                 team_id: row['teamID'],
                 name: row['name']
               })
end

Team.import [ :team_id, :name ], teams, batch_size: 200, on_duplicate_key_ignore: {conflict_target: [:team_id]}

Player.delete_all

players = []
CSV.foreach(Rails.root.join('lib/batting.csv'), headers: true) do |row|
  players << Player.new({
                          player_id: row['playerID'],
                          year_id: row['yearID'],
                          stint: row['stint'],
                          team_id: row['teamID'],
                          at_bat: row['AB'],
                          hits: row['H']
                    })
end

Player.import [:player_id, :year_id, :stint, :team_id, :at_bat, :hits ], players, batch_size: 1000
