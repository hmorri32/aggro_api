class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: { status: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def login
    if params[:user]
      user = User.find_by(email: params[:user][:email].to_s.downcase)
      if user && user.authenticate(params[:user][:password])
        auth_token = JsonWebToken.encode({user_id: user.id})
        render json: {auth_token: auth_token}, status: :ok
      else
        render json: {error: 'Invalid username / password'}, status: :unauthorized
      end
    else
      render json: { error: 'invalid params' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
