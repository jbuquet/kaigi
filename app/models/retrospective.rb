class Retrospective < ActiveRecord::Base
  has_many :stickies, -> { order({ created_at: :desc }) }
  has_many :users
  has_many :groups
  has_many :statuses

  def ungrouped_stickies
    stickies.ungrouped
  end

  def current_status
    statuses.where(duration: nil).last
  end

  def self.set_max_votes(votes_data)
    retrospective_id = votes_data['retrospective_id']

    retrospective = Retrospective.find(retrospective_id)

    retrospective.update_attribute(:max_votes, votes_data['max_votes'])
  end

  def manager
    users.first
  end

  def participants
    users.offset(1)
  end

  def create_general_group(retrospective_id)
    stickies_ids = self.ungrouped_stickies.collect(&:id)

    data = {
      name: 'General',
      retrospective_id: retrospective_id,
      initial_sticky_id: stickies_ids.pop,
      sticky_ids: stickies_ids
    }

    Group.create!(data)
  end
end