# Define a bare test case to use with Capybara
class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
  include Capybara
  include Rails.application.routes.url_helpers
  
  self.use_transactional_fixtures = false
  
  def assert_seen(text, opts={})
    if opts[:within]
      within(selector_for(opts[:within])) do
        assert page.has_content?(text)
      end
    else
      assert page.has_content?(text)
    end
  end
  
  def assert_flash(key, text)
    within(".flash.#{key}") do
      assert_seen(text)
    end
  end

  
end