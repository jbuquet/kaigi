class AddStickyTypeToStickies < ActiveRecord::Migration
  def change
    add_column :stickies, :sticky_status, :string
  end
end
