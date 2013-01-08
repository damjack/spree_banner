module Spree
  class Banner < ActiveRecord::Base
    attr_accessible :title, :url, :category, :position, :enabled, :attachment, :attachment_width, :attachment_height
    
    has_attached_file :attachment,
                :url  => "/spree/banner/:id/:style_:basename.:extension",
                :path => ":rails_root/public/spree/banner/:id/:style_:basename.:extension",
                :styles => lambda {|a| {
                  :thumbnail => "80x80#",
                  :custom => "#{a.instance.attachment_width}x#{a.instance.attachment_height}#"
                }},
                :convert_options => {
                  :thumbnail => "-gravity center",
                  :custom => "-gravity center"
                }
    
    after_post_process :find_dimensions
    
    validates_presence_of :category, :attachment_width, :attachment_height
    validates_attachment_presence :attachment
    validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], :message => "deve essere JPG, JPEG, PNG o GIF"
    
    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }
    
    # Load user defined paperclip settings
    if Spree::Config[:use_s3]
      s3_creds = { :access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket] }
      Spree::Banner.attachment_definitions[:attachment][:storage] = :s3
      Spree::Banner.attachment_definitions[:attachment][:s3_credentials] = s3_creds
      Spree::Banner.attachment_definitions[:attachment][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::Banner.attachment_definitions[:attachment][:bucket] = Spree::Config[:s3_bucket]
      Spree::Banner.attachment_definitions[:attachment][:s3_protocol] = Spree::Config[:s3_protocol] unless Spree::Config[:s3_protocol].blank?
    end

    Spree::Banner.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:attachment_styles])
    Spree::Banner.attachment_definitions[:attachment][:path] = Spree::Config[:attachment_path]
    Spree::Banner.attachment_definitions[:attachment][:url] = Spree::Config[:attachment_url]
    Spree::Banner.attachment_definitions[:attachment][:default_url] = Spree::Config[:attachment_default_url]
    Spree::Banner.attachment_definitions[:attachment][:default_style] = Spree::Config[:attachment_default_style]
        
    def initialize(*args)
      super(*args)
      last_banner = Banner.last
      self.position = last_banner ? last_banner.position + 1 : 0
    end
    
    def find_dimensions
      if self.attachment_width.blank? && self.attachment_height.blank?
        temporary = attachment.queued_for_write[:original]
        filename = temporary.path unless temporary.nil?
        filename = attachment.path if filename.blank?
        geometry = Paperclip::Geometry.from_file(filename)
        self.attachment_width  = geometry.width
        self.attachment_height = geometry.height
      end
    end
    
  end
end
