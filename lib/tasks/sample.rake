namespace :db do
  namespace :sample do
    desc "creates sample pages"
    task :cms do
      
      require Rails.root.join('config/environment.rb')
      %w(Home About Contact).each do |page|
        @page = Page.create(:title => page, :path => page == "Home" ? "/" : page)
        @content = @page.contents.first
        @content.body = Faker::Lorem.paragraphs(rand(4)).join("\n\n")
        @content.save
      end
      puts "\ndone."
      
    end
  end
end
