class CreateSystemSiteviews < ActiveRecord::Migration
 def change
    create_table :system_siteviews do |t|
      t.integer :renewal_id, null: false
      t.datetime :visit_date, null: false
	    t.string :google_event_start, null: false
      t.boolean :completed
      t.string :delayed_id_start
      
      t.timestamps null: false
    end	
  end
end
