require 'uri'

module RetrospectivesHelper

  def retrospective_link(retrospective)
    URI.join(root_url,retrospective_path(retrospective.public_key))
  end

  def set_timebox_in_current_status
    current_retro.current_status.status_type == Status::INVITE_USERS ||
      current_retro.current_status.status_type == Status::SET_VOTE_GROUPS_TIMEBOX ||
      current_retro.current_status.status_type == Status::SET_DISCUSS_STICKIES_TIMEBOX
  end

  def current_status_name
    case current_retro.current_status.status_type
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
    case current_retro.current_status.status_type
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
end