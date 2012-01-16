require 'generators/essentials_base'

module SpreeEssentials
  module Generators
    class CmsGenerator < SpreeEssentials::Generators::EssentialsBase
      
      desc "Installs required migrations for spree_essentials"
      source_root File.expand_path("../../templates/db/migrate", __FILE__)
      
      def copy_migrations
        migration_template "create_pages.rb",    "db/migrate/create_pages.rb"
        migration_template "create_contents.rb", "db/migrate/create_contents.rb"
        migration_template "add_spree_namespace.rb", "db/migrate/add_spree_namespace.rb"
      end

    end
  end
end
