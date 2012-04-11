require 'test_helper'

class Spree::Admin::ContentsIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::Content.destroy_all
    @page = Spree::Page.first || Factory.create(:spree_page)
  end
  
  should "have a link to new content" do
    visit spree.admin_page_contents_path(@page)
    btn = find(".actions a.button").native
    assert_match /#{spree.new_admin_page_content_path(@page)}$/, btn.attribute('href')
    assert_equal "New Content", btn.text
  end
  
  should "get new content" do  
    visit spree.new_admin_page_content_path(@page)
    assert has_content?("New Content")
    within "#new_content" do
      assert has_field?("Title")
      assert has_field?("Page")
      assert has_field?("Body")   
      assert has_field?("Context")   
      assert has_field?("Attachment")   
      assert has_field?("Link URL")
      assert has_field?("Link Text")
      assert has_field?("Hide Title")
    end
  end
    
  should "validate content" do
    visit spree.new_admin_page_content_path(@page)
    click_button "Create"
    within "#errorExplanation" do
      assert_seen "1 error prohibited this record from being saved:"
      assert_seen "Title can't be blank"
    end
  end
  
  should "create some content" do
    visit spree.new_admin_page_content_path(@page)
    within "#new_content" do
      fill_in "Title", :with => "Just some content"
      select @page.title, :from => "Page"
      fill_in "Body",  :with => "Just some words in the content..."
    end
    click_button "Create"
    assert_equal spree.admin_page_contents_path(@page), current_path
    assert_flash :notice, "Content has been successfully created!"
  end
  
  context "existing content" do    
    setup do
      @content = Factory.create(:spree_content, :page => @page)
    end
    
    should "edit and update" do
      visit spree.edit_admin_page_content_path(@page, @content)      
      within "#edit_content_#{@content.id}" do
        fill_in "Title", :with => "Just some content"
        select @page.title, :from => "Page"
        fill_in "Body",  :with => "Just some words in the content..."
      end
      click_button "Update"
      assert_equal spree.admin_page_contents_path(@page.reload), current_path
      assert_flash :notice, "Content has been successfully updated!"
    end
    
    should "not delete current attachment unless checkbox is checked" do
      @content.update_attribute(:attachment, sample_image)
      visit spree.edit_admin_page_content_path(@page, @content)
      click_button "Update"
      assert !@content.reload.attachment_file_name.blank?
    end
    
    should "delete current attachment" do
      @content.update_attribute(:attachment, sample_image)
      visit spree.edit_admin_page_content_path(@page, @content)
      click_link "Optional Fields"
      check "Delete current attachment"
      click_button "Update"
      assert @content.reload.attachment_file_name.blank?
    end
    
    should "get destroyed" do
      visit spree.admin_page_contents_path(@page)
      within "table.index" do
        find("a[href='#']").click
      end
      assert find_by_id("popup_ok").click
    end
    
  end
  
  context "several contents" do
  
    setup do
      setup_action_controller_behaviour(Spree::Admin::ContentsController)
      @contents = Array.new(2) {|i| Factory(:spree_content, :title => "Content ##{i + 1}", :page => @page, :position => i) }
    end
    
    should "update positions" do
      positions = Hash[@contents.map{|i| [i.id, 2 - i.position ]}]
      visit spree.admin_page_contents_path(@page)
      assert_seen "Content #1", :within => "tbody tr:first"
      assert_seen "Content #2", :within => "tbody tr:last"
      xhr :post, :update_positions, { :page_id => @page.to_param, :positions => positions }
      visit spree.admin_page_contents_path(@page)      
      assert_seen "Content #2", :within => "tbody tr:first"
      assert_seen "Content #1", :within => "tbody tr:last"
    end
  
  end
  
end
