class UsersController < ApplicationController

  def create
    user = User.create!(user_params)
    add_user_to_current_retro(user.id)

    redirect_to retrospective_path(current_retro.public_key)
  end

  private

  def user_params
    params.require(:user).permit(:name).merge(retrospective_id: current_retro.id,
                                              color: COLORS.sample)
  end

end