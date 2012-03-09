require 'test_helper'

class Spree::HomeIntegrationTest < SpreeEssentials::IntegrationCase
  
  setup do
    Spree::Page.destroy_all
    @images = Dir[File.expand_path("../../../../lib/tasks/sample", __FILE__) + "/*.jpg"]
  end
  
  should "redirect to products when no homepage is present" do
    visit "/"
    assert_equal spree.products_path, current_path
  end
  
  context "an existing homepage" do
  
    setup do
      @home = Spree::Page.create(:title => "Home", :meta_title => "Welcome to our homepage!", :path => "/")
      @home.contents.first.update_attributes(:body => "This is a test", :context => "main")
      @home.contents.create(:title => "Some might say...", :body => "This is another test", :context => "intro")
      @images.each { |image| 
        image = File.open(image)
        @home.images.create(:attachment => image, :alt => "Sailing", :viewable => @home)
        image.close
      }
      visit "/"
    end
    
    should "have proper page title" do
      assert_title "Spree Demo Site - Welcome to our homepage!"      
    end
    
    should "have proper contents" do
      within ".left .content-main" do
        assert_seen "Home", :within => "h1.title"
        assert_seen "This is a test", :within => "p"
      end
      within ".intro .content-main" do
        assert_seen "Some might say...", :within => "h1.title"
        assert_seen "This is another test", :within => "p"
      end
    end
        
    should "have a images in slideshow" do
      within "#content .slideshow" do
        @home.images.each do |img|
          assert has_xpath?("//img[@src='#{img.attachment.url(:slide)}']")
        end
      end
    end
    
  end
   
end
