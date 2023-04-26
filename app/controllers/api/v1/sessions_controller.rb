class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: UserSerializer.new(user), status: :created 
    else 
      render json: ErrorSerializer.bad_request(user.errors.full_messages), status: :bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end