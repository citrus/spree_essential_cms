def sample_image(path=nil)
  File.open(sample_image_path(path))
end

def sample_image_path(path=nil)
  path ||= "1.jpg"
  File.expand_path("../files/#{path}", __FILE__)
end

def setup_action_controller_behaviour(controller_class)
  @routes = Spree::Core::Engine.routes
  @controller = controller_class.new
end
