class CreateSlvcdata < ActiveRecord::Migration
  def change
    create_table :slvcdata do |t|
      t.integer :zip
      t.string :company
      t.string :market
      t.string :wrap 
      t.integer :hh_count 
      t.string :newspaper
      t.integer :highest_circulation
      t.string :newspaper_penetration
      t.string :county
      t.string :county_code
      t.integer :dma_num
      t.string :dma_name
      t.string :frequency
      t.string :ihd 
    end
  end
end
