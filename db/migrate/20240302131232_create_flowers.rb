class CreateFlowers < ActiveRecord::Migration[7.1]
  def change
    create_table :flowers do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :color
      t.string :event
      t.string :equipment
      t.string :sale
      t.string :vendor
      t.string :rating
      t.string :purchased_count
      t.timestamps
    end
  end
end
