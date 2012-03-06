unless Spree::User.const_defined?(:DestroyWithOrdersError)
  class Spree::User::DestroyWithOrdersError < StandardError; end
end
