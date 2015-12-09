class CreateCatalogsDevices < ActiveRecord::Migration
  def change
    create_table :catalogs_devices do |t|
      t.string :name, null: false
      t.string :unam_stock_number, null: false
      t.integer :location_id, null: false

      t.timestamps null: false
    end
  end
end
