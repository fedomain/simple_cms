class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
    	
    	t.string "name"
    	t.string "permalink"
    	t.integer "position"
    	t.boolean "visible", :default => true
		t.integer "subject_id"
    	# same as: t.references :subject    	

      t.timestamps null: false
    end

    add_index("pages", "permalink")
    add_index("pages", "subject_id")
  end

  def down
  	drop_table :pages
  end
end
