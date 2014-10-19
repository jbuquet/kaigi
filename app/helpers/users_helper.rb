module UsersHelper

  def user_initial(user)
    (user.name[0] || '').upcase
  end

  def current_user_can_delete?(sticky)
    return current_user_can_create?
    return true if current_user_is_manager?

    sticky.user == current_user
  end

  def current_user_can_group?
    return false unless current_retro
    return false unless current_user
    return false unless current_user_is_manager?
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::CREATE_GROUPS
  end

  def current_user_can_create?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::WRITE_STICKIES
  end

  def voting?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::VOTE_GROUPS
  end

  def grouping?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::CREATE_GROUPS
  end

  def current_user_can_vote?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::VOTE_GROUPS
  end

end