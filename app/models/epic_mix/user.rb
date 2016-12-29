module EpicMix
  # A valid user in epic mix
  class User
    attr_accessor :api, :info, :password, :stats, :username
    def initialize(username, password)
      @api      = Api.new
      @username = username
      @password = password
    end

    def token
      @token ||= token!
    end

    def stats
      @stats = stats!
    end

    def token!
      response = authenticate!
      return unless response.status == 200
      @info = JSON.parse(response.body)
      response.headers["Set-Cookie"].match(/ASP\.NET_SessionId=([^\;]+)/)[1]
    end

    def stats!
      response = userstats!
      return unless response.status == 200
      Rails.cache.fetch(cache_key, expires_in: 1.hour) do
        UserStats.new(self, JSON.parse(response.body))
      end
    end

    def authentication_path
      "/vailresorts/sites/epicmix/api/mobile/authenticate.ashx"
    end

    def userstats_path
      "/vailresorts/sites/epicmix/api/mobile/userstats.ashx"
    end

    def authentication_params
      {
        loginID: username,
        password: password
      }
    end

    def userstats_params
      {
        token: "ABCDEFG1234567890",
        timetype: "season"
      }
    end

    def id
      info && info["userID"]
    end

    def name
      info && info["userName"]
    end

    def vertical_feet
      stats.current_season.vertical_feet
    rescue StandardError
      0
    end

    private

    def cache_key
      "user-stats-#{Digest::SHA1.hexdigest(username + password)}"
    end

    def authenticate!
      api.client.post do |request|
        request.url authentication_path
        request.params = authentication_params
      end
    end

    def userstats!
      api.client.post do |request|
        request.url userstats_path
        request.headers["Cookie"] = cookie
        request.params = userstats_params
      end
    end

    def cookie
      [session_id, website, session_id].join("; ")
    end

    def session_id
      "ASP.NET_SessionId=#{token}"
    end

    def website
      "website#sc_wede=1"
    end
  end
end
