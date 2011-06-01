# install spree and migrate db
prepend_file 'config/application.rb', %(require "rake"
)

say_status "installing", "spree_core, spree_auth and spree_sample"

rake "spree_core:install spree_auth:install spree_sample:install"

say_status "installing", "spree_drop_shipping"
run "rails g spree_essentials:install"
run "rails g spree_essentials:blog"