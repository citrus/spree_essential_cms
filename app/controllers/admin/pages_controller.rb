class Admin::PagesController < Admin::BaseController
  resource_controller

  create.response do |wants|
    wants.html { redirect_to edit_admin_page_content_path(@page, @page.contents.first) }
  end

  update.response do |wants|
    wants.html { redirect_to object_url }
  end

  destroy.success.wants.js { render_js_for_destroy }

  def update_positions
    params[:positions].each do |id, index|
      Page.update_all(['position=?', index], ['id=?', id])
    end
    
    respond_to do |format|
      format.html { redirect_to admin_pages_url }
      format.js  { render :text => 'Ok' }
    end
  end

  private
  
    def object
      @object ||= Page.find_by_path(params[:id])
    end
  
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "page.asc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.order(:position).paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end