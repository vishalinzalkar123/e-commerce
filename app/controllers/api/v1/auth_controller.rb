class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :refresh]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: AuthenticationService.login(user)
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def refresh
    user = User.find_by(id: params[:user_id])
    tokens = AuthenticationService.refresh(user, params[:refresh_token])

    if tokens
      render json: tokens
    else
      render json: { error: 'Invalid refresh token' }, status: :unauthorized
    end
  end
end