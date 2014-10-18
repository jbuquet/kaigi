class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string      :name
      t.integer     :votes, default: 0

      t.references  :retrospective

      t.timestamps
    end
  end
end
