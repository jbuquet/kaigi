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
end