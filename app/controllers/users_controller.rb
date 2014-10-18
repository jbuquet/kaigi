class UsersController < ApplicationController

  def create
    user = User.create!(user_params.merge(:retrospective_id => current_retro.id))

    session[:user_id] = user.id

    redirect_to retrospective_path(current_retro.public_key)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end