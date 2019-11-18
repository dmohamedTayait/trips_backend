##
# API controller: Base class to handle authentication and error catching
#
class Api::V1::ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_driver

  rescue_from ActionController::ParameterMissing, with: :param_missing_handler
  rescue_from ActiveRecord::RecordInvalid, with: :could_not_save
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_handler

  def render_success(message = nil) 
    message = "success" unless message  
    render json: { message: message },  status: :ok 
  end 

  def render_error(error,code)
    render json: {
          message: error
      },  status: code
  end

  def current_driver
    @current_driver ||= authenticate_token
  end

  def authenticate_driver
    render_error("not_authenticated", :unauthorized) if current_driver.nil?
  end

  private

  def authenticate_token
    driver = Driver.find_by(auth_token: request.headers['token'])
    driver if driver
  end

  def restrict_access
    api_key = ApiKey.exists?(access_token: request.headers['Authorization'])
    render_error("unauthorized", :unauthorized) unless api_key
  end

  def param_missing_handler e
    render_error(e, :unprocessable_entity)
  end

  def could_not_save e
    render_error(e, :unprocessable_entity)
  end

  def record_not_found_handler e
    render_error(e, :not_found)
  end

  def unauthorized_user
    render_error("unauthorized", :unauthorized)
  end

end

