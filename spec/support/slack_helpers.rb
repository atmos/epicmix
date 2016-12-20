module SlackHelpers
  def command_params_for(text)
    {
      channel_id: "C99NNAY74",
      channel_name: "#general",
      command: "/epicmix",
      response_url: "https://hooks.slack.com/commands/T123YG08V/2459573/mfZPdDq",
      team_id: "T123YG08V",
      team_domain: "atmos-org",
      text: text
    }
  end

  def slack_omniauth_hash_defaults
    {
      description: nil,
      email: "atmos@atmos.org",
      first_name: "Corey",
      last_name: "Donohoe",
      image: "https://secure.gravatar.com/avatar/" \
             "a86224d72ce21cd9f5bee6784d4b06c7.jpg?s=192&d=" \
             "https%3A%2F%2Fslack.global.ssl.fastly.net" \
             "%2F7fa9%2Fimg%2Favatars%2Fava_0010-192.png",
      image_48: "https://secure.gravatar.com/avatar/" \
                "a86224d72ce21cd9f5bee6784d4b06c7.jpg?s=48&" \
                "d=https%3A%2F%2Fslack.global.ssl.fastly.net" \
                "%2F66f9%2Fimg%2Favatars%2Fava_0010-48.png",
      is_admin: true,
      is_owner: true,
      name: "Corey Donohoe",
      nickname: "atmos",
      team: "Zero Fucks LTD",
      team_id: "T123YG08V",
      time_zone: "America/Los_Angeles",
      user: "atmos",
      user_id: "U123YG08X"
    }
  end

  def slack_omniauth_hash_for_atmos
    credentials = {
      token: SecureRandom.hex(24)
    }

    OmniAuth::AuthHash.new(provider: "slack",
                           uid: "U024YG08X",
                           info: slack_omniauth_hash_defaults,
                           credentials: credentials)
  end

  # rubocop:disable Metrics/MethodLength
  def slack_omniauth_hash_for_non_admin
    info = {
      provider: "slack",
      uid: nil,
      info: {
      },
      credentials: {
        token: "xoxp-9101111159-5657146422-59735495733-3186a13efg",
        expires: false
      },
      extra: {
        raw_info: {
          ok: false,
          error: "missing_scope",
          needed: "identify",
          provided: "identity.basic"
        },
        web_hook_info: {
        },
        bot_info: {
        },
        user_info: {
          ok: false,
          error: "missing_scope",
          needed: "users:read",
          provided: "identity.basic"
        },
        team_info: {
          ok: false,
          error: "missing_scope",
          needed: "team:read",
          provided: "identity.basic"
        }
      }
    }
    OmniAuth::AuthHash.new(info)
  end
  # rubocop:enable Metrics/MethodLength
end
