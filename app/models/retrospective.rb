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

end