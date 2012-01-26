namespace :db do
  namespace :sample do
    desc "Create admin username and password"
    task :cms => :environment do
    
      require 'ffaker'
      
      unless Spree::Page.count == 0
        require 'highline/import'
        continue = ask("Sample data will destroy existing data. Continue? [y/n]")
        exit unless continue =~ /y/i
        Spree::Page.destroy_all
      end
          
      images = Dir[File.expand_path("../sample", __FILE__) + "/*.jpg"]
      
      home = Spree::Page.create(:title => "Home", :path => "/")
      home.contents.first.update_attributes(:body => Faker::Lorem.paragraphs().join("\n\n"), :context => "main")
      home.contents.create(:title => Faker::Lorem.words(3 + rand(3)).join(" "), :body => Faker::Lorem.sentence, :context => "intro")
      
      images.each {|image| 
        Spree::PageImage.create(:viewable => home, :attachment => File.open(image), :alt => "Sailing") 
      }
      
      %w(About Contact).each do |title|
        page = Spree::Page.create(:title => title, :path => title.downcase)
        page.contents.first.update_attributes(:body => Faker::Lorem.paragraphs().join("\n\n"))
      end
      
      puts "done."
      
    end
  end
end
