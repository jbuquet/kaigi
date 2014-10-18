class RetrospectivesController < ApplicationController

  def new
    @retros = Retrospective.all
  end

  def create
    retro = retro_params
    retro[:public_key] = SecureRandom.urlsafe_base64(nil, true)

    retro = Retrospective.create!(retro)

    redirect_to retrospective_path(retro.public_key)
  end

  def show
    @retro = Retrospective.find_by_public_key(params[:id])
  end

  private

  def retro_params
    params.require(:retrospective).permit(:name, :public_key)
  end

end