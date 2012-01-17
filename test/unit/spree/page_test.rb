require 'test_helper'

class Spree::PageTest < Test::Unit::TestCase

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
  
end
