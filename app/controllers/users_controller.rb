class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :show, :login, :destroy, :update, :index]

  # POST /users/login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = TokenHelper.encode(user_id: user.id)
      render json: {user: user, token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      token = TokenHelper.encode(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  # GET /users/:id
  def show
    user = User.find(params[:id])
    render json: user
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  # GET /users
  def index
    users = User.all
    render json: { users: [users]}
  end


  # PATCH/PUT /users/:id
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  # DELETE /users/:id
  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: 'User deleted' }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
