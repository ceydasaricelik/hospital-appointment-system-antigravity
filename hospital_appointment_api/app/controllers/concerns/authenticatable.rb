module Authenticatable
  extend ActiveSupport::Concern

  included do
    # Make current_user available if needed
  end

  def current_user
    @current_user
  end

  def authenticate_user!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    
    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
