require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  def setup
    Page.destroy_all
    @home_page   = Factory.create(:page, :title => "Home",  :path => "/")
    @about_page  = Factory.create(:page, :title => "About", :path => "/about-us")
    @nested_page = Factory.create(:page, :title => "Our Services", :path => "/about-us/services")
  end
  
  should "get the homepage" do
    get :show, :page_path => "/"
    assert_equal @home_page, assigns(:page)
    assert_response :success
  end
  
  should "get the about page" do
    get :show, :page_path => "/about-us"
    assert_equal @about_page, assigns(:page)
    assert_response :success
  end
    
  should "get a nested page" do
    get :show, :page_path => "/about-us/services"
    assert_equal @nested_page, assigns(:page)
    assert_response :success
  end
    
end