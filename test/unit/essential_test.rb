require_relative '../test_helper'

class EssentialTest < Test::Unit::TestCase

  def setup
  end
   
  should "register with spree_essentials" do
    puts "hell"
    
    puts SpreeEssentials.essentials
    #register :blog, SpreeEssentialCms
    
  end
  
end