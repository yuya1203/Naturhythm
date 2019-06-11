class AddBottleNameToMicroposts < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :bottle_name, :string
    add_column :microposts, :producer, :string
    add_column :microposts, :production_area, :string
    add_column :microposts, :evaluation, :string
  end
end
