class Admin::ContentsController < Admin::BaseController

  resource_controller 
  belongs_to :page

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  def update_positions
    @page = parent_object
    params[:positions].each do |id, index|
      @page.contents.update_all(['position=?', index], ['id=?', id])
    end
    
    respond_to do |format|
      format.html { redirect_to admin_page_contents_url(@oage) }
      format.js  { render :text => 'Ok' }
    end
  end

  destroy.success.wants.js { render_js_for_destroy }

  private
    
    def parent_object
	   @page ||= Page.find_by_path(params[:page_id])
    end
          
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "page.asc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end