class GroupIdToStickies < ActiveRecord::Migration

  def change
    add_column :stickies, :group_id, :integer
  end

end