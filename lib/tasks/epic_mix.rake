namespace :epic_mix do
  desc "Cache stuff from epicmix"
  task cache_fixtures: [:environment] do
    api = EpicMix::Api.new
    epic_mix_fixture_directory = Rails.root / "spec/fixtures/www.epicmix.com" \
                                              "/vailresorts/sites/epicmix" \
                                              "/api/mobile"

    %w{lifts mountains terrain weather}.each do |endpoint|
      response = api.client.get("/vailresorts/sites/epicmix/api/mobile/" \
                                "#{endpoint}.ashx?device=iphone")
      if response.status == 200
        output_file = epic_mix_fixture_directory / "#{endpoint}.ashx"
        File.open(output_file, "w") do |fp|
          fp.puts JSON.pretty_generate(JSON.parse(response.body))
        end
      else
        $stderr.puts "Unable to parse the #{endpoint} endpoint."
      end
    end
  end
end
