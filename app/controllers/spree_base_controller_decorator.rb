Spree::BaseController.class_eval do
  
  before_filter :get_pages
  
  def get_pages
    @page = Page.find_by_path(request.path) rescue nil
    scope = request.path =~ /^\/admin/ ? Page.scoped : Page.visible
    @pages = scope.order(:position).all
  end

end