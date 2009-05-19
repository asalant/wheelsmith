class Hub < ActiveRecord::Base

  validates_presence_of :brand, :description, :left_flange_diameter, :left_flange_to_center, :right_flange_diameter, :right_flange_to_center, :hole_count
  validates_inclusion_of :rear, :in => [true, false]

  def self.from_csv(row)
    rear = row[3].to_f == 0.0
    offset = rear ? 5 : 0
    hub = Hub.new :part_number => row[0],
                  :brand => row[2].strip,
                  :description => row[1].strip,
                  :rear => rear,
                  :left_flange_diameter => row[3 + offset].to_f,
                  :right_flange_diameter => row[4 + offset].to_f,
                  :left_flange_to_center => row[5 + offset].to_f,
                  :right_flange_to_center => row[6 + offset].to_f,
                  :hole_count => row[7 + offset],
                  :verified => true

    hub.description.gsub! /^#{hub.brand}\W+/, ''
    hub
  end

end
