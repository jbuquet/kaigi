class AddMaxVotesToRetrospective < ActiveRecord::Migration
  def change
    add_column :retrospectives, :max_votes, :integer, default: 5
  end
end