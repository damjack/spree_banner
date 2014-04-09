module Spree
  class BannerBox < ActiveRecord::Base
    acts_as_list :scope => :category
    
    has_attached_file :attachment,
                :url  => "/spree/banners/:id/:style_:basename.:extension",
                :path => ":rails_root/public/spree/banners/:id/:style_:basename.:extension",
                :styles => { :mini => "80x80#", :small => "120x120#" },
                :convert_options => { :all => '-strip -auto-orient' }
    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    after_post_process :find_dimensions

    validates_presence_of :category
    validates_attachment_presence :attachment
    validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], :message => I18n.t(:images_only)

    scope :enabled, lambda { |*categories|
      if categories.empty?
        where(:enabled => true)
      else
        where(:enabled => true).where(:category => categories)
      end
    }

    # Load user defined paperclip settings
    include Spree::Core::S3Support
    supports_s3 :attachment
    
    Spree::BannerBox.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:banner_styles])
    Spree::BannerBox.attachment_definitions[:attachment][:path] = Spree::Config[:banner_path]
    Spree::BannerBox.attachment_definitions[:attachment][:url] = Spree::Config[:banner_url]
    Spree::BannerBox.attachment_definitions[:attachment][:default_url] = Spree::Config[:banner_default_url]
    Spree::BannerBox.attachment_definitions[:attachment][:default_style] = Spree::Config[:banner_default_style]
    
    # for adding banner_boxes which are closely related to existing ones
    # define "duplicate_extra" for site-specific actions, eg for additional fields
    def duplicate
      enhance_settings
      p = self.dup
      p.category = 'COPY OF ' + category
      p.created_at = p.updated_at = nil
      p.url = url
      p.attachment = attachment

      # allow site to do some customization
      p.send(:duplicate_extra, self) if p.respond_to?(:duplicate_extra)
      p.save!
      p
    end

    def find_dimensions
      temporary = attachment.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = attachment.path if filename.blank?
      geometry = Paperclip::Geometry.from_file(filename)
      self.attachment_width = geometry.width
      self.attachment_height = geometry.height
    end

    def enhance_settings
      extended_hash = {}
      ActiveSupport::JSON.decode(SpreeBanner::Config[:banner_styles]).each do |key,value|
        extended_hash[:"#{key}"] = value
      end
      Spree::BannerBox.attachment_definitions[:attachment][:styles] = extended_hash
      Spree::BannerBox.attachment_definitions[:attachment][:path] = SpreeBanner::Config[:banner_path]
      Spree::BannerBox.attachment_definitions[:attachment][:url] = SpreeBanner::Config[:banner_url]
      Spree::BannerBox.attachment_definitions[:attachment][:default_url] = SpreeBanner::Config[:banner_default_url]
      Spree::BannerBox.attachment_definitions[:attachment][:default_style] = SpreeBanner::Config[:banner_default_style]
    end

    def self.categories_for_select
      unscoped.pluck(:category).uniq.sort
    end

  end
end
