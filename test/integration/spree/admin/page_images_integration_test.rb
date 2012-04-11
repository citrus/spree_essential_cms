require 'test_helper'

class Spree::Admin::PageImagesIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::PageImage.destroy_all
    @page = Spree::Page.first || Factory.create(:spree_page)
  end
  
  should "have a link to new page image" do
    visit spree.admin_page_images_path(@page)
    btn = find("#new_image_link").native
    assert_match /#{spree.new_admin_page_image_path(@page)}$/, btn.attribute('href')
    assert_equal "New Image", btn.text
  end
  
  should "get new page image" do  
    visit spree.new_admin_page_image_path(@page)
    assert_seen "New Image"
    within "#new_page_image" do
      assert has_field?("Attachment")
      assert has_field?("Alt")   
    end
  end
  
  should "validate page image" do
    visit spree.new_admin_page_image_path(@page)
    click_button "Create"
    within "#errorExplanation" do
      assert_seen "2 errors prohibited this record from being saved:"
      assert_seen "Attachment can't be empty"
      assert_seen "Attachment file name can't be empty"
    end
  end
  
  should "create page image" do
    visit spree.admin_page_images_path(@page)
    click_link "New Image"
    within "#new_page_image" do
      attach_file "Attachment", sample_image_path
      fill_in "Alt", :with => "alt text!"
    end
    click_button "Create"
    assert_equal spree.admin_page_images_path(@page), current_path
    assert_flash :notice, "Page image has been successfully created!"
  end
  
  context "existing page image" do    
    setup do
      @page_image = Factory.create(:spree_page_image, :viewable => @page)
    end
    
    should "edit and update" do
      visit spree.edit_admin_page_image_path(@page, @page_image)      
      within "#edit_page_image_#{@page_image.id}" do
        attach_file "Attachment", sample_image_path("2.jpg")
        fill_in "Alt", :with => "omg!"
      end
      click_button "Update"
      assert_equal spree.admin_page_images_path(@page), current_path
      assert_flash :notice, "Page image has been successfully updated!"
    end
    
    should "get destroyed" do
      visit spree.admin_page_images_path(@page)
      within "table.index" do
        find("a[href='#']").click
      end
      assert find_by_id("popup_ok").click
    end
    
  end
  
  context "several page images" do
  
    setup do
      setup_action_controller_behaviour(Spree::Admin::PageImagesController)
      @page_images = Array.new(2) {|i| Factory(:spree_page_image, :alt => "Image ##{i + 1}", :viewable => @page, :position => i) }
    end
    
    should "update positions" do
      positions = Hash[@page_images.map{|i| [i.id, 2 - i.position ]}]
      visit spree.admin_page_images_path(@page)
      assert_seen "Image #1", :within => "tbody tr:first"
      assert_seen "Image #2", :within => "tbody tr:last"
      xhr :post, :update_positions, { :page_id => @page.to_param, :positions => positions }
      visit spree.admin_page_images_path(@page)      
      assert_seen "Image #2", :within => "tbody tr:first"
      assert_seen "Image #1", :within => "tbody tr:last"
    end
  
  end
  
end
