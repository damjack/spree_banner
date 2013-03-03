class BannerNamespace < ActiveRecord::Migration
  def change
    rename_table :banners, :spree_banner_boxes
  end
end
