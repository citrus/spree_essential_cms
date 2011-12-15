require 'spree_essentials'

module SpreeEssentialCms

  def self.tab
    { :label => "Pages", :route => :admin_pages }
  end
  
  def self.sub_tab
    [ :pages, { :match_path => '/pages' }]
  end
  
  class Engine < Rails::Engine
    
    config.autoload_paths += %W(#{config.root}/lib)    
    
    config.to_prepare do
      #loads application's model / class decorators
      Dir.glob File.expand_path("../../app/**/*_decorator*.rb") do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      #loads application's deface view overrides
      Dir.glob File.expand_path("../../app/overrides/*.rb", __FILE__) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end
    
  end
  
end

SpreeEssentials.register :cms, SpreeEssentialCms
