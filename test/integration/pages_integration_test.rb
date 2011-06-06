require_relative '../test_helper'

class PagesIntegrationTest < ActiveSupport::IntegrationCase
  
  context "the homepage" do
  
    setup do
      Page.destroy_all
      @home = Page.create(:title => "Home", :meta_title => "Welcome to our homepage!", :path => "/")
      @home.contents.first.update_attributes(:body => "This is a test", :context => "main")
      @home.contents.create(:title => "Some might say...", :body => "This is another test", :context => "intro")
      Dir[File.expand_path("../../../lib/tasks/sample", __FILE__) + "/*.jpg"].each {
        |image| @home.images.create(:attachment => File.open(image), :alt => "Sailing")
      }
    end
    
    should "have proper page title" do
      visit root_path
      assert_title ""      
    end
    
    should "have proper contents" do
      visit root_path
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
      visit root_path
      within "#content .slideshow" do
        @home.images.each do |img|
          assert has_xpath?("//img[@src='#{img.attachment.url(:slide)}']")
        end
      end
    end
    
  end
    
end
