module FixturesHelpers
  def fixture_data(name)
    path = Rails.root.join("spec", "fixtures", "#{name}.json")
    File.read(path)
  end

  def epic_mix_fixture_data(name)
    path = Rails.root.join( \
      "spec", "fixtures", "www.epicmix.com", "vailresorts", "sites", \
      "epicmix", "api", "mobile", "#{name}" \
    )
    File.read(path)
  end

  def decoded_fixture_data(name)
    JSON.parse(fixture_data(name))
  end
end
