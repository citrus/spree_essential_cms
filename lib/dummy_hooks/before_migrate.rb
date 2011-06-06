say_status "installing", "spree_core, spree_auth"
rake "spree_core:install spree_auth:install"

say_status "installing", "spree_essentials and spree_essential_cms"
run "rails g spree_essentials:install"
run "rails g spree_essentials:cms"
