gsub_file 'config/application.rb', 'class Application < Rails::Application', %(class Application < Rails::Application
  include ::Rake::DSL
)

append_to_file 'config/application.rb', %(  
module ::RakeFileUtils
  extend Rake::FileUtilsExt
end
)