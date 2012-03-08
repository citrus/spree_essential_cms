require 'test_helper'

class Spree::Admin::PagesIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::Page.destroy_all
    @labels = %(Title, Meta Title, Meta Description, Meta Keywords, Path, Navigation Title).split(', ')
    @values = %(Just a page, Super Sweet Page Title, #{Faker::Lorem.paragraph}, one keyword, /some-page, Visit Page).split(', ')
  end
  
  should "get index and have a link to new page" do
    visit spree.admin_pages_path
    btn = find(".actions a.button").native
    assert_match /#{spree.new_admin_page_path}$/, btn.attribute('href')
    assert_equal "New Page", btn.text
  end
  
  should "get new page" do  
    visit spree.new_admin_page_path
    assert has_content?("New Page")
    within "#new_spree_page" do
      @labels.each do |f|
        assert has_field?(f)
      end
    end
  end
    
  should "validate page" do
    visit spree.new_admin_page_path
    click_button "Create"
    within "#errorExplanation" do
      assert_seen "2 errors prohibited this record from being saved:"
      assert_seen "Title can't be blank"
      assert_seen "Path can't be blank"
    end
  end
  
  should "create a page" do
    visit spree.new_admin_page_path
    within "#new_spree_page" do
      @labels.each_with_index do |label, index|
      	fill_in label, :with => @values[index]      
      end
    end
    click_button "Create"
    @page = Spree::Page.last
    assert_equal spree.edit_admin_page_content_path(@page, @page.contents.first), current_path
    assert_flash :notice, %(Page "Just a page" has been successfully created!)
  end
  
  context "an existing page" do    
    setup do
      @page = Factory.create(:spree_page)
    end
    
    should "get show" do
      visit spree.admin_page_path(@page)
      assert_seen @page.meta_title
      assert_seen @page.meta_description
      assert_seen @page.meta_keywords
      assert has_link?("Edit")
      within "#sidebar" do
        assert has_link?("Contents")
        assert has_link?("Images")
      end
    end
    
    should "edit and update" do
      visit spree.edit_admin_page_path(@page)
      
      within "#edit_spree_page_#{@page.id}" do
        @labels.each_with_index do |label, index|
        	fill_in label, :with => @values[index].reverse      
        end
      end
      click_button "Update"
      assert_equal spree.admin_page_path(@page.reload), current_path
      assert_flash :notice, %(Page "egap a tsuJ" has been successfully updated!)
    end
    
    should "get destroyed" do
      visit spree.admin_pages_path
      find("a[href='#']").click
      assert find_by_id("popup_ok").click
    end
    
  end
  
  context "The homepage" do
  
    setup do
      @page = Spree::Page.create(:title => "Home", :meta_title => "Welcome to our homepage!", :path => "/")
    end
    
    should "edit and update" do
      visit spree.edit_admin_page_path(@page)
      
      within "#edit_spree_page_#{@page.id}" do
        @labels.each_with_index do |label, index|
          next if label == "Path"
        	fill_in label, :with => @values[index]      
        end
      end
      click_button "Update"
      assert_equal spree.admin_page_path(@page.reload), current_path
      assert_flash :notice, %(Page "Just a page" has been successfully updated!)
    end
    
  end
  
  context "several pages" do
  
    setup do
      setup_action_controller_behaviour(Spree::Admin::PagesController)
      @pages = Array.new(2) {|i| Factory(:spree_page, :title => "Page ##{i + 1}", :position => i) }
    end
    
    should "update positions" do
      positions = Hash[@pages.map{|i| [i.id, 2 - i.position ]}]
      visit spree.admin_pages_path
      assert_seen "Page #1", :within => "tbody tr:first"
      assert_seen "Page #2", :within => "tbody tr:last"
      xhr :post, :update_positions, { :page_id => @page.to_param, :positions => positions }
      visit spree.admin_pages_path
      assert_seen "Page #2", :within => "tbody tr:first"
      assert_seen "Page #1", :within => "tbody tr:last"
    end
  
  end
  
end