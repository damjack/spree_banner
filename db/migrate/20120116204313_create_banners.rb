class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :presentation, :url
      t.string :category
      t.integer :position
      t.boolean :enabled, :default => false
      
      t.string   :attachment_content_type, :attachment_file_name
      t.datetime :attachment_updated_at
      t.integer  :attachment_width, :attachment_height
      t.integer  :attachment_size
      
      t.timestamps
    end
  end
end
