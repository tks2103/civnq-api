class UnconfirmedMatchSerializer < ActiveModel::Serializer
  attributes :id, :match_type, :game, :comment, :teams, :reporter_id

  def id
    object.id.to_s
  end

  def teams
	teams = object.teams.map { |team| 
		team.map { |player| 
			User.find_by(steamid: player).username
		} 
	}
  end

end
