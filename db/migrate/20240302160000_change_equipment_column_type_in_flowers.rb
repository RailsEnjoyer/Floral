class ChangeEquipmentColumnTypeInFlowers < ActiveRecord::Migration[7.1]
  def change
    remove_column :flowers, :equipment
    add_column :flowers, :equipment, :text, array: true, default: []
  end
end
