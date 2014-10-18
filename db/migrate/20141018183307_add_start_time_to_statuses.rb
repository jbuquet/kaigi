class AddStartTimeToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :start_time, :datetime
  end
end