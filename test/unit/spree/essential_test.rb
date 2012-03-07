require 'test_helper'

class Spree::EssentialTest < ActiveSupport::TestCase
   
  should "register with spree_essentials" do
    assert SpreeEssentials.has?(:cms)
  end
  
end
