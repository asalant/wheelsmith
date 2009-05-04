require 'csv'

namespace :db do
  namespace :import do
    desc 'Perform clean import of rims from rims.csv'
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

    desc 'Perform clean import of hubs from hubs.csv'
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
end
