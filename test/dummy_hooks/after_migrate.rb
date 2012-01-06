run "rails g spree_essentials:install"
run "rails g spree_essentials:cms"
rake "db:migrate", :env => "test"

# Uncomment the line below for demo
#rake "db:migrate db:seed db:sample:cms", :env => "development"
