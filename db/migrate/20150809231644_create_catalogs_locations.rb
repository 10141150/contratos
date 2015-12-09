class CreateCatalogsLocations < ActiveRecord::Migration
  def change
    create_table :catalogs_locations do |t|
      t.string :department, null: false
      t.string :responsible, null: false
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
