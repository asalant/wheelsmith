class CreateWheels < ActiveRecord::Migration
  def self.up
    create_table :wheels do |t|
      t.references :hub
      t.references :rim
      t.integer :spoke_pattern
      t.text :note

      t.timestamps
    end

    add_index :wheels, :hub_id
    add_index :wheels, :rim_id
  end

  def self.down
    drop_table :wheels
  end
end
