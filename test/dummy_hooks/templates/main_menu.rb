Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :name          => "spree_essential_cms_main_menu",
                     :insert_bottom => "#header[data-hook]",
                     :partial       => "spree/shared/main_menu",
                     :disabled      => false)
