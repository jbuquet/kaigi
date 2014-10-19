module RetrospectivesHelper

  def next_stage_button_name
    if current_retro.current_status.try(:status_type) == Status::ACTION_ITEMS
      'Finish'
    else
      'Next Stage'
    end
  end

  def inviting?
    return false unless current_retro
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::INVITE_USERS
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

  def discussing?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::DISCUSS_STICKIES
  end

  def defining_action_items?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::ACTION_ITEMS
  end

  def finished?
    return false unless current_retro
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::FINISH
  end

end