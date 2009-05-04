class CreateHubs < ActiveRecord::Migration
  def self.up
    create_table :hubs do |t|
      t.string :brand
      t.string :description
      t.boolean :rear
      t.float :right_flange_diameter
      t.float :right_flange_to_center
      t.float :left_flange_diameter
      t.float :left_flange_to_center
      t.integer :hole_count

      t.timestamps
    end
  end

  def self.down
    drop_table :hubs
  end
end
