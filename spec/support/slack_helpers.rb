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
