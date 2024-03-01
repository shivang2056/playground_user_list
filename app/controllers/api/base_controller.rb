class Api::BaseController < ActionController::API
  def error_response(error_message, status = :internal_server_error)
    render json: { error: error_message }, status: status
  end
end
