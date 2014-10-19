class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_retro

  COLORS = %w[#f69988 #f36c60 #e84e40 #f06292 #ec407a #e91e63 #ba68c8 #ab47bc #6a1b9a #9575cd
              #7986cb #5c6bc0 #3f51b5 #3949ab #29b6f6 #4fc3f7 #4dd0e1 #26c6da #42bd41 #2baf2b
              #dce775 #d4e157 #fff176 #ffee58 #ffca28 #ffa726 #fb8c00]

  def current_retro
    @current_retro ||= Retrospective.find_by_public_key(params[:retrospective_id] || params[:id])
  end
  helper_method :current_retro

  def current_user_id
    session_retro_users[current_retro.id.to_s]
  end
  helper_method :current_user_id

  def current_user
    @current_user ||= User.find_by_id(current_user_id)
  end
  helper_method :current_user

  def current_user_is_manager?
    user_is_manager?(current_retro)
  end
  helper_method :current_user_is_manager?

  def add_user_to_current_retro(user_id, is_manager = false)
    add_user_to_retro(current_retro, user_id, is_manager)
  end

  def add_user_to_retro(retro, user_id, is_manager = false)
    session_retro_users[retro.id] = user_id

    if is_manager
      session_retro_managers[retro.id] = true
    end
  end

  def session_retro_users
    session[:retro_users] ||= {}
  end

  def user_is_manager?(retro)
    session_retro_managers[retro.id.to_s]
  end

  def session_retro_managers
    session[:retro_managers] ||= {}
  end

  def require_retro
    return if controller_name == 'retrospectives' && (action_name == 'new' || action_name == 'create')
    return if current_retro

    redirect_to root_url, notice: 'Retrospective not found.'
  end

end
