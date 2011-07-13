Spree::BaseController.class_eval do
  
  before_filter :get_pages
  
  def get_pages
    admin = request.path =~ /^\/admin/
    @page = Page.find_by_path(request.path) rescue nil unless admin
    scope = admin ? Page.scoped : Page.visible
    @pages = scope.order(:position).all
  end

end
