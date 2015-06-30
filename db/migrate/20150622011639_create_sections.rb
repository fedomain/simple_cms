class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
    	
    	t.string "name"
    	t.integer "position"
    	t.boolean "visible", :default => true
    	t.string "content_type"
    	t.text "content"
    	t.integer "page_id"
    	# same as: t.references :page

      t.timestamps null: false
    end

    add_index("sections", "page_id")
  end

end
