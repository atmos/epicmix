module EpicMix
  # A user's stats for a single season
  class Season
    attr_accessor :stats, :data
    def initialize(stats, data)
      @stats = stats
      @data  = data
    end

    def time_tag_id
      data["timeTagID"]
    end

    def vertical_feet
      data["verticalFeet"]
    end
  end
end
