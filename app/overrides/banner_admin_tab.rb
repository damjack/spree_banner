Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "banner_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                      :text => "<%= tab(:banners, :url => spree.admin_banners_path) %>",
                      :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                      :name => "add_banner_setting_to_configuration_menu",
                      :insert_bottom => "[data-hook='admin_configurations_menu']",
                      :partial => "spree/admin/shared/banner_setting_configurations_menu")