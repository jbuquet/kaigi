class Sticky < ActiveRecord::Base
  belongs_to :retrospective
  belongs_to :user
  belongs_to :group

  def self.ungrouped
    where(group_id: nil)
  end

end