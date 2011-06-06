require_relative '../test_helper'

class PagesIntegrationTest < ActiveSupport::IntegrationCase
  
  setup do
    Page.destroy_all
  end
  
  context "the homepage" do
  
    setup do
      @home = Page.create(:title => "Home", :meta_title => "Welcome to our homepage!", :path => "/")
      @home.contents.first.update_attributes(:body => "This is a test", :context => "main")
      @home.contents.create(:title => "Some might say...", :body => "This is another test", :context => "intro")
      Dir[File.expand_path("../../../lib/tasks/sample", __FILE__) + "/*.jpg"].each {
        |image| @home.images.create(:attachment => File.open(image), :alt => "Sailing")
      }
      visit root_path
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
  
  context "any other page" do
    
    setup do
      @page = Page.create(:title => "Some Page", :path => "/some-page")
      @page.contents.first.update_attributes(:body => "OMG it really is a page")
      visit @page.path
    end
    
    should "have proper page title" do
      assert_title "Spree Demo Site - Some Page"      
    end
    
    should "have proper content" do
      within ".content-main" do
        assert_seen "Some Page", :within => "h1.title"
        assert_seen "OMG it really is a page", :within => "p"
      end
    end
    
  end
    
end
