class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def create
    @user = AdminUser.new(user_params)
    if @user.save
      render json: { message: "User created successfully" }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end