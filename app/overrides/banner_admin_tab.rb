Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "banner_box_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                      :text => "<%= tab(:banner_boxes, :url => spree.admin_banner_boxes_path) %>")

Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                      :name => "add_banner_box_setting_to_configuration_menu",
                      :insert_bottom => "[data-hook='admin_configurations_menu']",
                      :partial => "spree/admin/shared/banner_box_setting_configurations_menu")