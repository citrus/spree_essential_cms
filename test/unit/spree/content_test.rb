require 'test_helper'

class Spree::ContentTest < ActiveSupport::TestCase

  should validate_presence_of(:page)
  should validate_presence_of(:title)

  context "An existing piece of content" do
    
    setup do
      Spree::Page.destroy_all
      @page = Factory(:spree_page)
      @content = Factory(:spree_content, :page => @page)
    end
    
    context "with an image attached" do
    
      setup do
        @image = File.expand_path("../../../support/files/1.jpg", __FILE__)
        @content.update_attribute(:attachment, File.open(@image))
      end
      
      should "reprocess image when context changes" do
        assert !@content.attachment.exists?(:slide)
        @content.update_attribute(:context, "slideshow")
        assert @content.reload.attachment.exists?(:slide)
      end
      
      should "delete attachment" do
        @content.update_attribute(:delete_attachment, true)
        assert !@content.reload.attachment.exists?
        assert @content.attachment_file_name.blank?
      end
            
    end
    
  end

end
