class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_retro

  def current_retro
    @current_retro ||= Retrospective.find_by_public_key(params[:id])
  end
  helper_method :current_retro

  def require_retro
    return if controller_name == 'retrospectives' && (action_name == 'new' || action_name == 'create')
    return if current_retro

    redirect_to root_url, notice: 'Retrospective not found.'
  end

end
