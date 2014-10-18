class AddStickyTypeToStickies < ActiveRecord::Migration
  def change
    add_column :stickies, :sticky_type, :string
  end
end
