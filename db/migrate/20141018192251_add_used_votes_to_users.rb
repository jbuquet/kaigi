class AddUsedVotesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :used_votes, :integer, default: 0
  end
end