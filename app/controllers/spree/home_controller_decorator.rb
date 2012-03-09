Spree::HomeController.class_eval do
  
  before_filter :get_homepage
  
  def index
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
    render :template => "spree/pages/home"      
  end
  
  private
  
    def get_homepage
      @page = Spree::Page.find_by_path("/")
      redirect_to products_url if @page.nil?
      @page
    end
    
    def accurate_title
      @page.meta_title unless @page.nil?
    end
  
end
