require 'test_helper'

class Spree::PageTest < ActiveSupport::TestCase

  def setup
    Spree::Page.destroy_all
  end
  
  should validate_presence_of(:title)
  should validate_presence_of(:path)
  should have_many(:contents).dependent(:destroy)
  should have_many(:images).dependent(:destroy)
  
  should "return true if root" do
    page = Factory.create(:spree_page, :path => "/")
    assert page.root?
  end
  
  should "return false unless root" do
    page = Factory.create(:spree_page, :path => "/another")
    assert !page.root?
  end
  
  context "With a new page" do
  
    setup do
      @page = Spree::Page.new
    end
  
    should "strip trailing slashes when setting page" do
      %w(/path /path/ /path//).each do |path|
        @page.path = path
        assert_equal "/path", @page.path
      end      
    end
  
    should "strip trailing dashes when setting page" do
      %w(/path /path- /path--).each do |path|
        @page.path = path
        assert_equal "/path", @page.path
      end      
    end
  
    should "strip trailing underscores when setting page" do
      %w(/path /path_ /path__).each do |path|
        @page.path = path
        assert_equal "/path", @page.path
      end      
    end
  
  end
  
end
