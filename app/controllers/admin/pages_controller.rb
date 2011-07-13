class Admin::PagesController < Admin::ResourceController
  
  def translated_object_name
    I18n.t('page.model_name')
  end
  
  def location_after_save
    case params[:action]
      when "create"
        edit_admin_page_content_path(@page, @page.contents.first)
      else
        admin_page_path(@page)
    end        
  end

  def update_positions
    params[:positions].each do |id, index|
      Page.update_all(['position=?', index], ['id=?', id])
    end
    respond_to do |format|
      format.html { redirect_to admin_pages_path }
      format.js  { render :text => 'Ok' }
    end
  end

  private
  
    def find_resource
      @page ||= Page.find_by_path(params[:id])
    end
  
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "page.asc"
      @search = Page.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:orders_per_page], :page => params[:page])
    end

end
