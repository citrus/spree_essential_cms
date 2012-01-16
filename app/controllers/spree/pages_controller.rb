class Spree::PagesController < Spree::BaseController
  before_filter :get_page, :only => :show

  def show
    if @page.root?
      @posts    = Spree::Post.live.limit(5)    if SpreeEssentials.has?(:blog)
      @articles = Spree::Article.live.limit(5) if SpreeEssentials.has?(:news)
      render :template => 'pages/home'
    end
  end

  private

    def get_page
      @page = Spree::Page.includes(:images, :contents).active.find_by_path(page_path) rescue nil
      raise ActionController::RoutingError.new(page_path) if @page.nil?
    end

    def page_path
      params[:page_path] || "/"
    end

    def accurate_title
      @page.meta_title
    end

end
