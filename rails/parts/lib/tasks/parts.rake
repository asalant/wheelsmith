require 'csv'

namespace :db do
  namespace :import do
    desc 'Perform clean import of rims from rims.txt'
    task :rims => :environment do
      puts "Clearing rim database"
      Rim.delete_all

      File.open(File.join(RAILS_ROOT, "db/rims.txt"),"r") do |file|
        while (row = file.gets) do
          rim = Rim.from_csv(row.split /\t/)
          puts "Adding #{rim.description}"
          rim.save!
        end
      end
    end

    desc 'Perform clean import of hubs from hubs.txt'
    task :hubs => :environment do
      puts "Clearing hub database"
      Hub.delete_all

      File.open(File.join(RAILS_ROOT, "db/hubs.txt"),"r") do |file|
        while (row = file.gets) do
          hub = Hub.from_csv(row.split /\t/)
          puts "Adding #{hub.description}"
          hub.save!
        end
      end
    end

    desc 'Perform clean import of rims and hubs'
    task :all => [:rims, :hubs] do
        
    end
  end

  namespace :bootstrap do

    desc 'Create initial sample wheels'
    task :wheels => :environment do
      puts "Clearing wheel database"
      Wheel.delete_all

      Wheel.create! :hub => Hub.find_by_part_number('HU9238'),
              :rim => Rim.find_by_part_number('RM4508'),
              :spoke_pattern => 3,
              :note => "Sample rear wheel\nDelete this example if you like."

      Wheel.create! :hub => Hub.find_by_part_number('HU7712'),
              :rim => Rim.find_by_part_number('RM2230B'),
              :spoke_pattern => 0,
              :note => "Sample front wheel\nDelete this example if you like."

      puts "Created #{Wheel.count :all} wheels"
    end

  end
end
