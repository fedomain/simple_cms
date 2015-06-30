class CreateSubjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
    	t.string "name"
    	t.integer "position"
    	t.boolean "visible", :default => true

      t.timestamps null: false
    end
  end

  def down
    drop_table :subjects
  end

end