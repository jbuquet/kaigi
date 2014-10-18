class RetrospectivesController < ApplicationController

  def new
    @retros = Retrospective.all
    render layout: 'landing'
  end

  def create
    retrospective_data = retrospective_params
    owner_name = retrospective_data.delete(:owner_name)

    retrospective = Retrospective.create!(retrospective_data.merge(public_key: SecureRandom.urlsafe_base64))

    user = retrospective.users.create!(:name => owner_name, color: COLORS.sample)

    session[:is_manager] = true
    add_user_to_retro(retrospective, user.id)

    redirect_to retrospective_path(retrospective.public_key)
  end

  def show

  end

  private

  def retrospective_params
    params.require(:retrospective).permit(:name, :owner_name, :public_key)
  end

end