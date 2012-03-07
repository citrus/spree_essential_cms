require 'test_helper'

class Spree::ContentTest < ActiveSupport::TestCase

  should validate_presence_of(:page)
  should validate_presence_of(:title)

end
