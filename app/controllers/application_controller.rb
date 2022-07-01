class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

  before_action :authorize

  private
  def authorize
    @current_user = User.find_by(id: session[:user_id])

    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end

  def render_not_found
      render json: { error: "Not found" }, status: :not_found
  end
  
  
  def render_invalid(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

end
