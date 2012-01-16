class Spree::PageController < Spree::BaseController

  before_filter :get_page, :only => :index


  def show
  end

  private

    def get_page
      @page = Spree::Page.active.find_by_path(page_path)
      return raise ActionController::RoutingError.new(page_path) unless @page
    end

    def page_path
      params[:path] || "/"
    end

end
