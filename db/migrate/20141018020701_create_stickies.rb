class CreateStickies < ActiveRecord::Migration
  def change
    create_table :stickies do |t|
      t.text        :body

      t.references  :user
      t.references  :retrospective

      t.timestamps
    end
  end
end