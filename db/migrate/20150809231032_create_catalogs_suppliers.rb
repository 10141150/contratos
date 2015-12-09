class CreateCatalogsSuppliers < ActiveRecord::Migration
  def change
    create_table :catalogs_suppliers do |t|
      t.string :business_name, null: false
      t.string :contact, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :phone_office, null: false

      t.timestamps null: false
    end
  end
end
