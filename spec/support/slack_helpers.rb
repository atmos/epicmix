# rubocop:disable Metrics/ModuleLength
module SlackHelpers
  def command_params_for(text)
    {
      channel_id: "C99NNAY74",
      channel_name: "#general",
      command: "/epicmix",
      response_url: "https://hooks.slack.com/commands/T123YG08V/2459573/mfZPdDq",
      team_id: "T092F92CG",
      team_domain: "atmos-org",
      text: text
    }
  end

  # rubocop:disable Metrics/MethodLength
  def slack_omniauth_hash_for_install
    info = {
      "provider": "slack_install",
      "uid": "U0YJYFQ4E",
      "info": {
        "nickname": "atmos",
        "team": "Atmos Dot Org",
        "user": "atmos",
        "team_id": "T0YJVLHHA",
        "user_id": "U0YJYFQ4E",
        "name": "atmos",
        "team_domain": "atmos-dot-org"
      },
      "credentials": {
        "token": "xoxp-327031619588-32647214150-343462754261-30758e732gab0f253ce2f744f577f6e4",
        "expires": false
      },
      "extra": {
        "raw_info": {
          "ok": true,
          "url": "https://atmos-dot-org.slack.com/",
          "team": "Atmos Dot Org",
          "user": "atmos",
          "team_id": "T0YJVLHHA",
          "user_id": "U0YJYFQ4E"
        },
        "web_hook_info": {
        },
        "bot_info": {
        },
        "user_info": {
          "ok": false,
          "error": "missing_scope",
          "needed": "users:read",
          "provided": "identify,commands,team:read"
        },
        "team_info": {
          "ok": true,
          "team": {
            "id": "T0YJVLHHA",
            "name": "Atmos Dot Org",
            "domain": "atmos-dot-org",
            "email_domain": "",
            "icon": {
              "image_34": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_34.png",
              "image_44": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_44.png",
              "image_68": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_68.png",
              "image_88": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_88.png",
              "image_102": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_102.png",
              "image_132": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_132.png",
              "image_original": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_original.png",
              "image_230": "https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-05-02/39342903600_5e13f2a19ddacc8ffd06_132.png"
            }
          }
        }
      }
    }
    OmniAuth::AuthHash.new(info)
  end

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

  def stub_authenticated_user_for_commands
    token = "xoxp-9101111159-5657146422-59735495733-3186a13efg"
    stub_json_request(:get,
                      "https://slack.com/api/users.identity?token=#{token}",
                      fixture_data("slack.com/identity.basic"))
    User.from_omniauth(slack_omniauth_hash_for_non_admin)
  end
end
# rubocop:enable Metrics/ModuleLength
