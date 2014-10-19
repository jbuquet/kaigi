class CreateActionItems < ActiveRecord::Migration
  def change
    create_table :action_items do |t|
      t.text :action

      t.references :retrospective

      t.timestamps
    end
  end
end