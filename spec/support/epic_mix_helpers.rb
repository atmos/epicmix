module EpicMixHelpers
  def epic_mix_accept_headers
    {
      "Accept"          => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Content-Length"  => "0",
      "Content-Type"    => "application/json",
      "User-Agent"      => "EpicMix 47000 (iPhone; iPhone OS 7.1.2; en_US)"
    }
  end

  def epic_mix_authenticated_response
    {
      status: 200,
      body: epic_mix_fixture_data("authenticate"),
      headers: {
        "Set-Cookie" => "ASP.NET_SessionId=abcdefghijklmnopqrstuvwx"
      }
    }
  end

  def epic_mix_invalid_credentials_response
    {
      status: 400,
      body: "Invalid Credentials",
      headers: {
        "Set-Cookie" => "ASP.NET_SessionId=cdefghijklmnopqrstuvwxyz"
      }
    }
  end

  def epic_mix_api_url(suffix)
    "https://www.epicmix.com/vailresorts/sites/epicmix/api/mobile/#{suffix}"
  end
end
