class RetrospectivesController < ApplicationController

  def new
    @retros = Retrospective.all
    render layout: 'landing'
  end

  def create
    retrospective_data = retrospective_params
    owner_name = retrospective_data.delete(:owner_name)

    retrospective = Retrospective.create!(retrospective_data.merge(:public_key => SecureRandom.urlsafe_base64(nil, true)))

    user = User.create!(:name => owner_name, :retrospective => retrospective)

    session[:is_manager] = true
    session[:user_id] = user.id

    redirect_to retrospective_path(retrospective.public_key)
  end

  def show
    session[:user_id]
  end

  private

  def retrospective_params
    params.require(:retrospective).permit(:name, :owner_name, :public_key)
  end

end