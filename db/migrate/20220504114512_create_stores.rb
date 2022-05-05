class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :coname
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :naics
      t.integer :sic 
      t.integer :company_id
      t.string :source
    end
  end
end
