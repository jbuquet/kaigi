class Status < ActiveRecord::Base
  belongs_to :retrospective

  WRITE_STICKIES    = 'write_stickies'
  VOTE_GROUPS       = 'vote_groups'
  DISCUSS_STICKIES  = 'discuss_stickies'

  def self.set_status(status_data)
    retrospective_id = status_data.delete('retrospective_id')
    retrospective = Retrospective.find(retrospective_id)

    current_status_id = retrospective.current_status_id

    if !current_status_id
      status = Status.create!({ :status_type => WRITE_STICKIES,
                       :estimated_duration =>  status_data['estimated_duration'],
                       :retrospective_id => retrospective_id
                     })

      retrospective.update_attribute(:current_status_id, status.id)

    else
      current_status = Status.find(current_status_id)

      if current_status.status_type == WRITE_STICKIES
        status = Status.create!({ :status_type => VOTE_GROUPS,
                         :estimated_duration =>  status_data['estimated_duration'],
                         :retrospective_id => retrospective_id
                       })

        retrospective.update_attribute(:current_status_id, status.id)

      elsif current_status.status_type == VOTE_GROUPS
        status = Status.create!({ :status_type => DISCUSS_STICKIES,
                                  :estimated_duration =>  status_data['estimated_duration'],
                                  :retrospective_id => retrospective_id
                                })

        retrospective.update_attribute(:current_status_id, status.id)

      elsif current_status.status_type == DISCUSS_STICKIES
        # TODO
      end
    end
  end
end