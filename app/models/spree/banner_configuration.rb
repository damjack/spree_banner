module Spree
  class BannerConfiguration < Preferences::Configuration
    preference :banner_default_url, :string, default: '/spree/banners/:id/:style/:basename.:extension'
    preference :banner_path, :string, default: ':rails_root/public/spree/banners/:id/:style/:basename.:extension'
    preference :banner_url, :string, default: '/spree/banners/:id/:style/:basename.:extension'
    preference :banner_styles, :string, default: "{\"mini\":\"48x48>\",\"small\":\"100x100>\",\"large\":\"800x200#\"}"
    preference :banner_default_style, :string, default: 'small'
  end
end
