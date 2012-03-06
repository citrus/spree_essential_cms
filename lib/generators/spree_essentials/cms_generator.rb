module SpreeEssentials
  module Generators
    class CmsGenerator < Rails::Generators::Base
      
      desc "Installs required migrations for spree_essentials"
            
      def copy_migrations
        rake "spree_essential_cms:install:migrations"
      end

    end
  end
end
