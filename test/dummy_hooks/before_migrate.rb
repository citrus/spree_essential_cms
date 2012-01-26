rake "spree:install:migrations"

insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

run "rails g spree_essentials:install"
run "rails g spree_essentials:cms"

# remove all stylesheets except core  
%w(admin store).each do |ns|
  js  = "app/assets/javascripts/#{ns}/all.js"
  css = "app/assets/stylesheets/#{ns}/all.css"
  template "#{ns}/all.js", js, :force => true
  template "#{ns}/all.css", css, :force => true
end
