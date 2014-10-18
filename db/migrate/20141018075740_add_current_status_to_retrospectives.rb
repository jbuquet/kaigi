class AddCurrentStatusToRetrospectives < ActiveRecord::Migration
  def change
    add_column :retrospectives, :current_status_id, :integer
  end
end
