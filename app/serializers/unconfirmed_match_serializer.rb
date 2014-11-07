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

  def match_type
	if object.match_type == 0
		return "FFA"
	end
	if object.match_type == 1
		return "Duel"
	end
	if object.match_type == 2
		return "Teamer"
	end
  end

  def game
	if object.game == 0
		return "Civilization V"
	end
	if object.game == 1
		return "Civilization Beyond Earth"
	end
  end

  def reporter_id
  	User.find_by(steamid: object.reporter_id).username
  end

end
