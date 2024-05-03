module Authentication
  extend ActiveSupport::Concern
  include AuthToken

  attr_reader :current_user

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    unless token && decoded_token = parse_auth_token(token)
      render json: { error: 'Not authorized' }, status: :unauthorized
      return
    end

    @current_user = User.find(decoded_token['user_id'])
  rescue JWT::DecodeError
    render json: { error: 'Invalid auth token' }, status: :unauthorized
  end
end
