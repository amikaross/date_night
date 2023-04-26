class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else 
      render json: ErrorSerializer.bad_request(user.errors.full_messages), status: :bad_request
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user && user == current_user
      render json: UserSerializer.new(user)
    elsif user.nil? 
      render json: ErrorSerializer.not_found(controller_name.singularize), status: :not_found
    else
      render json: ErrorSerializer.not_authorized, status: :bad_request 
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end