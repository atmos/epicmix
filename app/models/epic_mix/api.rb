module EpicMix
  # API wrapper for interacting with epicmix.com
  class Api
    def user_agent
      "EpicMix 47000 (iPhone; iPhone OS 7.1.2; en_US)"
    end

    def client
      @client ||= Faraday.new(url: "https://www.epicmix.com") do |connection|
        connection.headers["Content-Type"] = "application/json"
        connection.headers["User-Agent"] = user_agent
        connection.adapter Faraday.default_adapter
      end
    end
  end
end
