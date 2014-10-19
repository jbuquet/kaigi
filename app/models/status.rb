class Status < ActiveRecord::Base
  belongs_to :retrospective

  INVITE_USERS                  = 'invite_users'
  WRITE_STICKIES                = 'write_stickies'
  CREATE_GROUPS                 = 'create_groups'
  SET_VOTE_GROUPS_TIMEBOX       = 'set_vote_groups_timebox'
  VOTE_GROUPS                   = 'vote_groups'
  SET_DISCUSS_STICKIES_TIMEBOX  = 'set_discuss_stickies_timebox'
  DISCUSS_STICKIES              = 'discuss_stickies'
  FINISH                        = 'finish'

  def self.set_current_status(status_data)
    retrospective_id = status_data.delete('retrospective_id')
    retrospective = Retrospective.find(retrospective_id)

    status = Status.find(retrospective.current_status_id)

    if status.status_type == INVITE_USERS
      new_status = Status.create!({ :status_type => WRITE_STICKIES,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })

    elsif status.status_type == WRITE_STICKIES
      new_status = Status.create!({ :status_type => CREATE_GROUPS,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })

    elsif status.status_type == CREATE_GROUPS
      new_status = Status.create!({ :status_type => SET_VOTE_GROUPS_TIMEBOX,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })

    elsif status.status_type == SET_VOTE_GROUPS_TIMEBOX
      new_status = Status.create!({ :status_type => VOTE_GROUPS,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })

    elsif status.status_type == VOTE_GROUPS
      new_status = Status.create!({ :status_type => SET_DISCUSS_STICKIES_TIMEBOX,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })

    elsif status.status_type == SET_DISCUSS_STICKIES_TIMEBOX
      new_status = Status.create!({ :status_type => DISCUSS_STICKIES,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })
    elsif status.status_type == DISCUSS_STICKIES
      new_status = Status.create!({ :status_type => FINISH,
                                    :estimated_duration =>  status_data['estimated_duration'],
                                    :retrospective_id => retrospective_id
                                  })
    end


    status.update_attribute(:duration, Time.now.to_i - status.start_time.to_i)
    new_status.update_attribute(:start_time, Time.now) if new_status
    retrospective.update_attribute(:current_status_id, new_status.id || nil)
  end
end