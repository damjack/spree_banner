Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "banner_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                      :text => "<%= tab(:banners, :url => spree.admin_banners_path) %>",
                      :disabled => false)