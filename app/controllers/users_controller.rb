class UsersController < ApplicationController

  def create
    User.create!(user_params.merge(:retrospective_id => 3))

    session[:user_in_retro] = true

    redirect_to retrospective_path(3)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end