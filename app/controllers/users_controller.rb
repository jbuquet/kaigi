class UsersController < ApplicationController

  def create
    params_user = user_params
    params_user.merge!(name: USER_NAMES.sample) if user_params[:name].blank?

    user = User.create!(params_user)
    add_user_to_current_retro(user.id)

    redirect_to retrospective_path(current_retro.public_key)
  end

  private

  def user_params
    params.require(:user).permit(:name).merge(retrospective_id: current_retro.id,
                                              color: COLORS.sample)
  end

end