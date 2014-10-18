class Retrospective < ActiveRecord::Base
  has_many :stickies
  has_many :users
end