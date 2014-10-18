class Status < ActiveRecord::Base
  belongs_to :retrospective

  WRITE_STICKIES    = 'write_stickies'
  VOTE_GROUPS       = 'vote_groups'
  DISCUSS_STICKIES  = 'discuss_stickies'

  def self.start_current_status(status_data)
    retrospective_id = status_data.delete('retrospective_id')
    retrospective = Retrospective.find(retrospective_id)

    status = Status.where(retrospective_id: retrospective_id).last

    if !status
      new_status = Status.create!({ :status_type => WRITE_STICKIES,
                       :estimated_duration =>  status_data['estimated_duration'],
                       :retrospective_id => retrospective_id
                     })
    elsif status.status_type == WRITE_STICKIES
      new_status = Status.create!({ :status_type => VOTE_GROUPS,
                       :estimated_duration =>  status_data['estimated_duration'],
                       :retrospective_id => retrospective_id
                     })
    elsif status.status_type == VOTE_GROUPS
      new_status = Status.create!({ :status_type => DISCUSS_STICKIES,
                       :estimated_duration =>  status_data['estimated_duration'],
                       :retrospective_id => retrospective_id
                     })
    end

    retrospective.update_attribute(:current_status_id, new_status.id)
  end

  def self.end_current_status(retrospective_id)
    retrospective = Retrospective.find(retrospective_id)

    status = Status.find(retrospective.current_status_id)

    status.update_attribute(:duration, 100)
    retrospective.update_attribute(:current_status_id, nil)
  end
end