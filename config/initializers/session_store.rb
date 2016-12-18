# Be sure to restart your server when you modify this file.
Rails.application.config.session_store :redis_store, servers: {
                                                      namespace: "session"
                                                     },
                                                     expires_in: 5.minutes,
                                                     key: "_epicmix_session"
Rollbar.configuration.scrub_fields |= [ "_epicmix_session", "session_id" ]
