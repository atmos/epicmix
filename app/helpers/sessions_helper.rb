# Helpers related to session authentication
module SessionsHelper
  def decoded_params_origin
    JSON.parse(Base64.decode64(params[:origin])).with_indifferent_access
  rescue StandardError
    nil
  end

  def decoded_omniauth_origin
    JSON.parse(Base64.decode64(omniauth_origin)).with_indifferent_access
  rescue StandardError
    nil
  end

  def omniauth_origin
    request.env["omniauth.origin"]
  end

  def omniauth_info_user_id
    omniauth_info["info"]["user_id"]
  end

  def omniauth_refresh_token
    omniauth_info["credentials"]["refresh_token"]
  end

  def omniauth_expiration
    Time.at(omniauth_info["credentials"]["expires_at"]).utc
  end

  def omniauth_info
    request.env["omniauth.auth"]
  end
end
