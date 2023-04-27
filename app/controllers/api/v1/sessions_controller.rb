class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: :created 
    else
      render json: ErrorSerializer.bad_credentials, status: :bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end