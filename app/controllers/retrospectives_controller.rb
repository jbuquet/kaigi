class RetrospectivesController < ApplicationController

  def new
    @retros = Retrospective.all
  end

  def create
    retrospective_data = retrospective_params
    manager_name = retrospective_data.delete(:managerName)

    retrospective = Retrospective.create!(retrospective_data.merge(:public_key => SecureRandom.urlsafe_base64(nil, true)))

    User.create!(:name => manager_name, :retrospective => retrospective)

    session[:is_manager] = true
    session[:user_in_retro] = true

    redirect_to retrospective_path(retro.public_key)
  end

  def show
    @user_in_retro = session[:user_in_retro]
    @retro = Retrospective.find_by_public_key(params[:id])
  end

  private

  def retrospective_params
    params.require(:retrospective).permit(:name, :managerName, :public_key)
  end

end