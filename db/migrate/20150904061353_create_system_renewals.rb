class CreateSystemRenewals < ActiveRecord::Migration
  def change
    create_table :system_renewals do |t|
      t.integer :contract_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.float :monto, null: false
	    t.string :google_event_start, null: false
	    t.string :google_event_end, null: false
      t.integer :delayed_id_start
      t.integer :delayed_id_end

      t.timestamps null: false
    end
	add_foreign_key(:system_contracts, :catalogs_suppliers, column: 'supplier_id')
	add_foreign_key(:system_contracts, :catalogs_devices, column: 'device_id')
  	add_foreign_key(:catalogs_devices, :catalogs_locations, column: 'location_id')
	add_foreign_key(:system_renewals, :system_contracts, column: 'contract_id')
	add_foreign_key(:system_siteviews, :system_renewals, column: 'renewal_id')
  end
end
