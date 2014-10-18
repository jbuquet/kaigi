class AddInitialStickyIdToGroups < ActiveRecord::Migration

  def change
    add_column :groups, :initial_sticky_id, :integer
  end

end