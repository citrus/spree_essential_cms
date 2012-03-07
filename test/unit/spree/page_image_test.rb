require 'test_helper'

class Spree::PageImageTest < ActiveSupport::TestCase
  
  should belong_to(:viewable)
  
  setup do
    @page_image = Spree::PageImage.new
  end
  
  should "validate no attachment errors" do
    @page_image.attachment.errors[:attachment_file_size] = "Is to large.."
    assert !@page_image.valid?
    assert @page_image.errors.include?(:attachment)
  end
  
  %w(image/jpeg image/gif image/png image/tiff).each do |mime|  
    should "return true for #{mime} as image content" do
      @page_image.attachment_content_type = mime
      assert @page_image.image_content?
    end
  end
  
  %w(application/pdf text/css).each do |mime|  
    should "return false for #{mime} as image content" do
      @page_image.attachment_content_type = mime
      assert !@page_image.image_content?
    end
  end
  
  should "have blank attachment sizes hash if page is not image content" do
    hash = {}
    assert_equal hash, @page_image.attachment_sizes
  end
  
  %w(image/jpeg image/gif image/png image/tiff).each do |mime|  
    should "have attachment sizes hash for #{mime}" do
      @page_image.attachment_content_type = mime
      hash = { :mini => '48x48>', :small => '150x150>', :medium => '420x300>', :large => '900x650>' }
      assert_equal hash, @page_image.attachment_sizes
    end
  end
  
  %w(image/jpeg image/gif image/png image/tiff).each do |mime|  
    should "have slide attachment size if page is root" do
      @page_image.viewable = Spree::Page.new(:path => "/")
      @page_image.attachment_content_type = mime
      hash = { :mini => '48x48>', :small => '150x150>', :medium => '420x300>', :large => '900x650>', :slide => '950x250#'}
      assert_equal hash, @page_image.attachment_sizes
    end
  end
  
end
