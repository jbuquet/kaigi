class Group < ActiveRecord::Base
  belongs_to :retrospective
  has_many :stickies
  has_one :initial_sticky, class_name: :Sticky

  def self.order_by_votes
    order(votes: :desc)
  end

end