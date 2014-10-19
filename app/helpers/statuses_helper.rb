module StatusesHelper

  def status_show_in_summary?(status)
    # Status::INVITE_USERS,
    [Status::WRITE_STICKIES, Status::CREATE_GROUPS, Status::VOTE_GROUPS,
     Status::DISCUSS_STICKIES].include?(status.status_type)
  end

  def current_status_name
    status_name(current_retro.current_status)
  end

  def status_name(status)
    case status.try(:status_type)
    when Status::INVITE_USERS
      'Invite users'
    when Status::WRITE_STICKIES
      'Write stickies'
    when Status::CREATE_GROUPS
      'Create groups'
    when Status::VOTE_GROUPS
      'Vote groups'
    when Status::DISCUSS_STICKIES
      'Discuss stickies'
    when Status::FINISH
      'Sum up'
    else
      ''
    end
  end

  def next_status_name
    case current_retro.current_status.try(:status_type)
    when Status::INVITE_USERS
      'Write stickies'
    when Status::SET_VOTE_GROUPS_TIMEBOX
      'Vote groups'
    when Status::SET_DISCUSS_STICKIES_TIMEBOX
      'Discuss stickies'
    else
      ''
    end
  end

  def set_timebox_in_current_status
    current_retro.current_status.try(:status_type) == Status::INVITE_USERS ||
      current_retro.current_status.try(:status_type) == Status::SET_VOTE_GROUPS_TIMEBOX ||
      current_retro.current_status.try(:status_type) == Status::SET_DISCUSS_STICKIES_TIMEBOX
  end

  def default_timebox
    case current_retro.current_status.try(:status_type)
    when Status::INVITE_USERS
      10
    when Status::SET_VOTE_GROUPS_TIMEBOX
      5
    when Status::SET_DISCUSS_STICKIES_TIMEBOX
      40
    else
      ''
    end
  end

  def status_estimated_duration(status)
    if !status.estimated_duration || status.status_type == Status::CREATE_GROUPS
      'N/A'
    else
      seconds_to_string(status.estimated_duration)
    end
  end

end