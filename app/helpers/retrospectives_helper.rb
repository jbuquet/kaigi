require 'uri'

module RetrospectivesHelper

  def retrospective_link(retrospective)
    URI.join(root_url,retrospective_path(retrospective.public_key))
  end

  def set_timebox_in_current_status
    current_retro.current_status.try(:status_type) == Status::INVITE_USERS ||
      current_retro.current_status.try(:status_type) == Status::SET_VOTE_GROUPS_TIMEBOX ||
      current_retro.current_status.try(:status_type) == Status::SET_DISCUSS_STICKIES_TIMEBOX
  end

  def current_status_name
    case current_retro.current_status.try(:status_type)
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

end