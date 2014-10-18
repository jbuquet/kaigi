class User < ActiveRecord::Base
  belongs_to :retrospective

  def has_votes_left?
    return false unless retrospective

    retrospective.max_votes - self.used_votes > 0
  end

end