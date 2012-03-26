class BannerNamespace < ActiveRecord::Migration
  def change
    rename_table :banners, :spree_banners
  end
end
