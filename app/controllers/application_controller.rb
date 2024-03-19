class ApplicationController < ActionController::API
    before_action :authenticate_user

    private

    def authenticate_user
        token = request.headers['Authorization']
        unless token && (decoded_token = TokenHelper.decode(token)) && (user_id = decoded_token['user_id']) && (current_user = User.find_by(id: user_id))
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end
    
end
