class AuthenticationService
  AccessExpiry = 15.minutes
  RefreshExpiry = 7.days

  def self.login(user)
    access_token = JwtService.encode({ user_id: user.id }, AccessExpiry.from_now)
    refresh_token = SecureRandom.hex(64)

    user.update!(refresh_token_digest: BCrypt::Password.create(refresh_token, cost: BCrypt::Engine::MIN_COST))

    { access_token: access_token, refresh_token: refresh_token }
  end

  def self.refresh(user, refresh_token)
    return nil unless user.refresh_token_digest && BCrypt::Password.new(user.refresh_token_digest).is_password?(refresh_token)

    login(user)
  end
end