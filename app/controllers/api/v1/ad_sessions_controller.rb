##
# Active Directory Sessions Controller: Handle AD user authentication/login
#
class Api::V1::AdSessionsController < Api::V1::ApiController
  skip_before_action :authenticate_driver#, only: [:create, :browser_wsfed, :failure]

  api! 'Create new AD session - Set Token Expiry - Return auth_token'
  example '
      #Active Directory User
      "user": {
        "id": 22,
        "name": "Rasmus",
        "auth_token": "AQKFWTgTz6Unc45uyB8wzmgG",
        "token_expiry": "2019-03-15T15:28:21.000Z",
        "created_at": "2019-03-12T11:36:34.000Z",
        "subrole": "mentor",
        "jobtitle": "mentor",
        "address": "Edisonsvej 1",
        "phone": "4578786766",
        "postal_code": null,
        "city": null,
        "away_message": null,
        "thumbnail": "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBYUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--cbad6628ac3b3607bf95d15e14d46f36ee71478c/Sk%C3%A6rmbillede%202019-02-27%20kl.%2005.50.20.png?disposition=attachment"
      }'
  def create
    Rails.logger.debug "HEY, WHATS UP"
    begin
      Rails.logger.debug "HELLO WORLD"
      oauth = OauthService.new(request.env['omniauth.auth'])
      Rails.logger.debug oauth.inspect

      if user = oauth.validate_oauth_account
        Rails.logger.debug user.inspect
        user.set_auth_token

        if session[:return_url]
          query_object = CGI::escape(user.as_api_response(:AD).to_json)
          redirect_to session[:return_url] + "?user=" + query_object and return
        end

        render_for_api :AD, json: user
      end
    rescue => e
      Rails.logger.debug "Got exception: " + e.inspect
      render_error(e, translate("errors.messages.login.login_unable"), :unauthorized)
    end
  end

  api! 'Return Error when AD User Authentication failed'
  def failure
    message = params[:message] ? params[:message] : translate("errors.messages.ad_authentication.failure")
    render_error(message, translate("errors.messages.ad_authentication.failure"), :unauthorized)
  end

  def browser_wsfed
    Rails.logger.debug "HELLO WORLD BROWSER WSFED"
    if params.has_key?(:return_url)
      session[:return_url] = params[:return_url]
    end

    redirect_to "/auth/wsfed"
  end

end
