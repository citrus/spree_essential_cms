require_relative '../../test_helper'

class Admin::PagesIntegrationTest < ActiveSupport::IntegrationCase

  setup do
    Page.destroy_all
    @labels = %(Title, Meta Title, Meta Description, Meta Keywords, Path, Navigation Title).split(', ')
    @values = %(Just a page, Super Sweet Page Title, #{Faker::Lorem.paragraph}, one keyword, /some-page, Visit Page).split(', ')
  end
  
  should "have a link to new page" do
    visit admin_pages_path
    btn = find(".actions a.button").native
    assert_match /#{new_admin_page_path}$/, btn.attribute('href')
    assert_equal "New Page", btn.text
  end
  
  should "get new page" do  
    visit new_admin_page_path
    assert has_content?("New Page")
    within "#new_page" do
      @labels.each do |f|
        assert has_field?(f)
      end
    end
  end
    
  should "validate page" do
    visit new_admin_page_path
    click_button "Create"
    within "#errorExplanation" do
      assert_seen "2 errors prohibited this record from being saved:"
      assert_seen "Title can't be blank"
      assert_seen "Path can't be blank"
    end
  end
  
  should "create a page" do
    visit new_admin_page_path
    within "#new_page" do
      @labels.each_with_index do |label, index|
      	fill_in label, :with => @values[index]      
      end
    end
    click_button "Create"
    assert_equal admin_page_content_path(@page, @page.contents.first), current_path    
    assert_flash :notice, %(Page "Just a page" has been successfully created!)
  end  
  
  context "an existing page" do    
    setup do
      @page = Factory.create(:page)
    end
    
    should "edit and update" do
      visit edit_admin_page_path(@page)
      
      within "#edit_page_#{@page.id}" do
        @labels.each_with_index do |label, index|
          next if label == 'Pageed At'
        	fill_in label, :with => @values[index].reverse      
        end
      end
      click_button "Update"
      assert_equal admin_page_path(@page.reload), current_path
      assert_flash :notice, %(Page "egap a tsuJ" has been successfully updated!)
    end
    
    should "get destroyed" do
      visit admin_pages_path
      find("a[href='#']").click
      assert find_by_id("popup_ok").click
    end
    
  end
  
end
