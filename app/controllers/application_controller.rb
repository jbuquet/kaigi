class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_retro

  def current_retro
    @current_retro ||= Retrospective.find_by_public_key(params[:retrospective_id] || params[:id])
  end
  helper_method :current_retro

  def current_user_id
    session[:user_id]
  end
  helper_method :current_user_id

  def current_user
    @current_user ||= User.find_by_id(current_user_id)
  end
  helper_method :current_user

  def require_retro
    return if controller_name == 'retrospectives' && (action_name == 'new' || action_name == 'create')
    return if current_retro

    redirect_to root_url, notice: 'Retrospective not found.'
  end

end
