##
# Sessions Controller: Handle Drivers logins, logout actions
#
class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_driver, only: :create

  api! 'Create new session - Return auth_token'
  example '
  {
    "driver": {
        "id": 1,
        "name": "Tayseer",
        "email": "tayeseer@hotmail.com",
        "auth_token": "H1WPpw5xDFvK6sk6t5c2CauP",
        "created_at": "2019-11-05T11:49:59.723Z"
    }
  }'
  def create
    if driver = Driver.can_login?(params[:email],params[:password])
      driver.set_auth_token
      render_for_api :basic, json: driver
    else
      render_error("login_unable", 422)
    end
  end

  api! 'Invalidates the driver token.'
  def destroy
    current_driver.reset_access_token
    render_success
  end

end
