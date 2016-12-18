ENV["APP_NAME"] ||= "epicmix"

CoalCar::HealthChecks.verify :slack do |service|
  client = Faraday.new(url: "https://slack.com")
  resp = client.get("/api/api.test") do |req|
    req.headers["Accept"] = "application/json"
  end
  if resp.status == 200
    body = JSON.parse(resp.body)
    indicator = body.fetch("ok", false)
    service.healthy = indicator == true
  else
    service.healthy = false
  end
end
