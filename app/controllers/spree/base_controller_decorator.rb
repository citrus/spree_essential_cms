Spree::BaseController.class_eval do

  before_filter :get_pages
  helper_method :get_current_page
  
  def get_current_page
    @page = Spree::Page.find_by_path(request.fullpath)
  end
  
  def get_pages
    return if request.path =~ /^\/+admin/
    @pages ||= Spree::Page.visible.order(:position).all
  end

end
