class ::Admin::ContentsController < ::Admin::ResourceController

  before_filter :load_resource
  before_filter :parent, :only => :index
  
  before_filter :get_pages, :only => [ :new, :edit, :create, :update ]

  belongs_to :page
  
  def update_positions
    @page = parent
    params[:positions].each do |id, index|
      @page.contents.update_all(['position=?', index], ['id=?', id])
    end
    respond_to do |format|
      format.html { redirect_to admin_page_contents_url(@oage) }
      format.js  { render :text => 'Ok' }
    end
  end
  
  private
    
    def get_pages
      @pages = Page.order(:position).all
    end
    
    def parent
	    @page ||= Page.find_by_path(params[:page_id])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "page.asc"
      @search = parent.contents.metasearch(params[:search])
      @collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
    end

end
