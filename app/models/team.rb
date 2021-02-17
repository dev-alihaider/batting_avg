class Team < ApplicationRecord
  has_many :players, class_name: 'Player', foreign_key: 'team_id', primary_key: 'team_id'
end
