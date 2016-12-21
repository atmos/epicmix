module EpicMix
  # A user's stats in epic mix
  class UserStats
    attr_accessor :user, :stats
    def initialize(user, stats)
      @user  = user
      @stats = stats
    end

    def seasons
      @seasons ||= stats["seasonStats"].map { |data| Season.new(self, data) }
    end

    def current_season_id
      stats["currentSeason"]["timeTagId"]
    end

    def current_season
      seasons.find { |season| season.time_tag_id == current_season_id }
    end
  end
end
