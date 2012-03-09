require 'test_helper'

class Spree::PagesIntegrationTest < SpreeEssentials::IntegrationCase
  
  setup do
    Spree::Page.destroy_all
    @images = Dir[File.expand_path("../../../../lib/tasks/sample", __FILE__) + "/*.jpg"]
  end
    
  context "any other page" do
    
    setup do
      @page = Spree::Page.create(:title => "Some Page", :meta_description => "This is the description", :meta_keywords => "just, a, keyword", :path => "/some-page")
    end
    
    should "have proper meta tags" do
      visit @page.path
      assert_title "Spree Demo Site - Some Page"      
      assert_meta :description, "This is the description"
      assert_meta :keywords, "just, a, keyword"
    end
    
    context "with content that doesn't have an image" do
      
      setup do
        @page.contents.first.update_attributes(:body => "OMG it really is a page")
      end
      
      should "have proper content" do
        visit @page.path
        within ".content-main" do
          assert_seen "Some Page", :within => "h1.title"
          assert_seen "OMG it really is a page", :within => "p"
        end
      end
      
      should "hide title is specified" do
        @page.contents.first.update_attributes(:hide_title => true)
        visit @page.path
        within ".content-main" do
          assert !has_selector?("h1.title")          
          assert_seen "OMG it really is a page", :within => "p"
        end
      end
      
    end
    
    
    context "with content that has an image" do
      
      setup do
        @content = @page.contents.first
        @content.update_attributes(:body => "OMG it really is a page", :attachment => File.open(@images.first))
      end
      
      should "have proper content" do
        visit @page.path
        within ".content-left" do
          assert has_xpath?("//img[@src='#{@content.attachment.url(:medium)}']")
        end
        within ".content-right" do
          assert_seen "Some Page", :within => "h1.title"
          assert_seen "OMG it really is a page", :within => "p"
        end
      end
      
    end
    
  end
  
  
  context "with several existing pages" do
    
    setup do
      @home_page    = Factory.create(:spree_page, :title => "Home",  :path => "/")
      @another_home = Factory.create(:spree_page, :title => "Another Home",  :path => "/home")
      @about_page   = Factory.create(:spree_page, :title => "About", :path => "/about-us")
      @nested_page  = Factory.create(:spree_page, :title => "Our Services", :path => "/about-us/services")
    end
    
    should "get the homepage" do
      visit "/"
      assert_title @home_page.title
    end
    
    should "get the page called home" do
      visit "/home"
      assert_title @another_home.title
    end
    
    should "get the about page" do
      visit "/about-us"
      assert_title @about_page.title
    end
      
    should "get a nested page" do
      visit "/about-us/services"
      assert_title @nested_page.title
    end
      
    should "render 404" do
      visit "/a/page/that/doesnt/exist"
      assert_seen "Error" 
    end    
              
  end    
end
