class Retrospective < ActiveRecord::Base
  has_many :stickies
  has_many :users
  has_many :groups
  has_many :statuses

  def ungrouped_stickies
    stickies.ungrouped
  end

end