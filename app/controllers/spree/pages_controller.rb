class Spree::PagesController < Spree::BaseController

  def show
    @page = Spree::Page.current
    raise ActionController::RoutingError.new("No route matches [GET] #{request.fullpath}") if @page.nil? 
    if @page.root?
      @posts    = Spree::Post.live.limit(5)    if SpreeEssentials.has?(:blog)
      @articles = Spree::Article.live.limit(5) if SpreeEssentials.has?(:news)
      render :template => 'spree/pages/home'
    end
  end

  private

    def accurate_title
      @page.meta_title
    end

end
