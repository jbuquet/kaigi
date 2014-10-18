class CreateRetrospectives < ActiveRecord::Migration
  def change
    create_table :retrospectives do |t|
      t.string :name
      t.text :public_key
      t.timestamps
    end
  end
end
