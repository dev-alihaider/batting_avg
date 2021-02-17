class BattingAvgController < ApplicationController

  def index
    player_data = {}
    teams = Team.all.pluck(:team_id, :name).to_h
    Player.where("at_bat > 0 AND hits > 0").find_in_batches(start: 0, batch_size: 5000) do |group|
      group.group_by{|x| [x.player_id, x.year_id]}.each do |k, v|
        previous_data = player_data[k[0] + "_" + k[1].to_s] || {hits_count: 0, at_bats_count: 0, teams: []}
        player_data[k[0] + "_" + k[1].to_s] = {
          player: k[0],
          year: k[1],
          teams: (previous_data[:teams] << v.map{|x| teams[x.team_id]}).flatten.uniq,
          hits_count: previous_data[:hits_count] + v.sum {|x| x.hits},
          at_bats_count: previous_data[:at_bats_count] + v.sum {|x| x.at_bat}
        }
      end
    end

    @avg_data = []
    player_data.each do |k,v|
      @avg_data << {player: v[:player], year: v[:year], teams: v[:teams], teams_count: v[:teams].count, hits_count: v[:hits_count],
                    at_bats_count: v[:at_bats_count],
                    batting_avg: (v[:hits_count].to_f / v[:at_bats_count]).round(3) }
    end
  end
end
