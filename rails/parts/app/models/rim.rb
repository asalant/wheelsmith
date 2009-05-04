class Rim < ActiveRecord::Base

  validates_presence_of :brand, :description, :size, :erd, :offset, :hole_count

  def self.from_csv(row)
    rim = Rim.new :part_number => row[0],
                  :brand => row[2].strip,
                  :description => row[1].strip,
                  :size => row[3],
                  :erd => row[4].to_f,
                  :offset => row[5].to_f,
                  :hole_count => row[6]

    rim.description.gsub! /^#{rim.brand}\W+/, ''
    rim
  end
  
end
