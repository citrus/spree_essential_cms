Spree::BaseController.class_eval do

  before_filter :get_pages

  def get_pages
    admin = request.path =~ /^\/+admin/
    return unless admin
    @page = Spree::Page.find_by_path(request.path)
    @pages = Spree::Page.visible.order(:position).all
  end

end
