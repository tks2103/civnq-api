class UnconfirmedMatch
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Match

  store_in collection: "unconfirmed_matches"


  def self.confirm_matches
    old_matches = UnconfirmedMatch.where(:created_at.lte => (Time.now - 3.days))
    new_matches = old_matches.map { |match| ConfirmedMatch.create(match.attributes) }
    old_matches.map { |match| match.delete }
  end


  def self.validate(params)
    return false if not params[:game].is_a? Integer
    return false if not params[:match_type].is_a? Integer
    return false if params[:teams].any? { |team| team.length <= 0 }
    return false if params[:teams].length >= 11
    return false if params[:teams].any? { |team|
      team.any? { |player|
        player.is_a? String
      }
    }
    return false if not params[:comment].is_a? String
    return true
  end

  module MatchType
    FFA     = 0
    Duel    = 1
    Teamer  = 2
  end

  module GameType
    CivV    = 0
    CivBE   = 1
  end
end
