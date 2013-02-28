Spree::AppConfiguration.class_eval do
  # Preferences related to banner settings
  preference :banner_default_url, :string, :default => '/spree/banners/:id/:style/:basename.:extension'
  preference :banner_path, :string, :default => ':rails_root/public/spree/banners/:id/:style/:basename.:extension'
  preference :banner_url, :string, :default => '/spree/banners/:id/:style/:basename.:extension'
  preference :banner_styles, :string, :default => "{\"mini\":\"80x80#\",\"small\":\"120x120#\"}"
  preference :banner_default_style, :string, :default => 'small'
end