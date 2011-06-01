class PossiblePage
  def self.matches?(request)
    path = request.fullpath
    return false if path =~ /(^\/(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user))/
    count = Page.active.where(:path => path).count
    0 < count
  end
end

Rails.application.routes.draw do
  
  namespace :admin do
  
    resources :pages do
      collection do
        post :update_positions
      end
      
      resources :contents do
        collection do
          post :update_positions
        end
      end
      
      resources :images, :controller => "page_images" do
        collection do
          post :update_positions
        end
      end
    end
  
  end

  constraints(PossiblePage) do
    get '(:page_path)', :to => 'pages#show', :page_path => /.*/, :as => :page
  end
  
end
