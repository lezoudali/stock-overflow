class UsersController < ApplicationController
  def show
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to root_path
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
