module SpreeEssentials
  module Generators
    class EssentialsBase < Rails::Generators::Base
    
      include Rails::Generators::Migration      

      def self.count!
        @count ||= 0
        (@count += 1) * 3
      end

      def self.next_migration_number(path)
        @time ||= Time.new.utc
        if ActiveRecord::Base.timestamped_migrations
          (@time + self.count!).strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
    end
  end
end