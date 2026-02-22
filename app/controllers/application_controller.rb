class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :authenticate_request

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    render json: { error: "Not authorized" }, status: :forbidden
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    
    decoded = JsonWebToken.decode(token)
    
    if decoded.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
      return
    end
    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  attr_reader :current_user
end