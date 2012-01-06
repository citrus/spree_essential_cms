require 'test_helper'

class EssentialTest < Test::Unit::TestCase
   
  should "register with spree_essentials" do
    assert SpreeEssentials.has?(:cms)
  end
  
end
