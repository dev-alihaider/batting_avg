class Player < ApplicationRecord
  belongs_to :team, class_name: 'Team', foreign_key: 'team_id', primary_key: 'team_id'
end
