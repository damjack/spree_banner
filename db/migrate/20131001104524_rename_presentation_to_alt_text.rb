class RenamePresentationToAltText < ActiveRecord::Migration
  def change
    rename_column :spree_banner_boxes, :presentation, :alt_text
  end
end
