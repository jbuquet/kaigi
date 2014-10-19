module RetrospectivesHelper

  def next_stage_button_name
    if current_retro.current_status.try(:status_type) == Status::DISCUSS_STICKIES
      'Finish'
    else
      'Next Stage'
    end
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

  def finished?
    return false unless current_retro
    return false unless current_user
    return false unless current_retro.current_status

    current_retro.current_status.status_type == Status::FINISH
  end

end