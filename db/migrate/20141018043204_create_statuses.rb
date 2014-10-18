class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :status_type
      t.integer :estimated_duration
      t.integer :duration

      t.references :retrospective

      t.timestamps
    end
  end
end
