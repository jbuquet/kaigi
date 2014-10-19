class User < ActiveRecord::Base
  belongs_to :retrospective

  def has_votes_left?
    return false unless retrospective

    remaining_votes > 0
  end

  def remaining_votes
    retrospective.max_votes - used_votes
  end

end