class Retrospective < ActiveRecord::Base
  has_many :stickies, -> { order({ created_at: :desc }) }
  has_many :users
  has_many :groups
  has_many :statuses

  def ungrouped_stickies
    stickies.ungrouped
  end

  def current_status
    Status.where(retrospective_id: self.id, duration: nil).last
  end
end