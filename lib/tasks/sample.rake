namespace :db do
  namespace :sample do
    desc "Create admin username and password"
    task :cms => :environment do
    
      # dependent on spree_core
      require 'faker'
      require 'highline/import'
    
      continue = ask("Sample data will destroy existing data. Continue? [y/n]", String) do |q|
        q.echo = true
        q.whitespace = :strip
      end
      
      exit unless continue =~ /y/i
      
      Page.destroy_all
      
      images = Dir[File.expand_path("../sample", __FILE__) + "/*.jpg"]
      
      home = Page.create(:title => "Home", :path => "/")
      home.contents.first.update_attributes(:body => Faker::Lorem.paragraphs().join("\n\n"))
      images.each {|image| home.images.create(:attachment => File.open(image), :alt => "Sailing") }
      
      %w(About Contact).each do |title|
        page = Page.create(:title => title, :path => title.downcase)
        page.contents.first.update_attributes(:body => Faker::Lorem.paragraphs().join("\n\n"))
      end
      
      puts "done."
            
    end
  end
end
