class CreateRims < ActiveRecord::Migration
  def self.up
    create_table :rims do |t|
      t.string :brand
      t.string :description
      t.integer :size
      t.float :erd
      t.float :offset
      t.integer :hole_count

      t.timestamps
    end
  end

  def self.down
    drop_table :rims
  end
end
