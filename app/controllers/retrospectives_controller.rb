class RetrospectivesController < ApplicationController

  def new
    @retros = Retrospective.all
  end

  def create
    retrospective_data = retrospective_params
    owner_name = retrospective_data.delete(:owner_name)

    retrospective = Retrospective.create!(retrospective_data.merge(:public_key => SecureRandom.urlsafe_base64(nil, true)))

    User.create!(:name => owner_name, :retrospective => retrospective)

    session[:is_manager] = true
    session[:user_in_retro] = true

    redirect_to retrospective_path(retrospective.public_key)
  end

  def show
    @user_in_retro = session[:user_in_retro]
  end

  private

  def retrospective_params
    params.require(:retrospective).permit(:name, :owner_name, :public_key)
  end

end