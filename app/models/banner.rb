class Banner < ActiveRecord::Base
  
  attr_accessible :category, :url, :position, :attachment_width, :attachment_height, :enabled, :attachment
  
  has_attached_file :attachment,
            :url  => "/spree/banner/:id/:style_:basename.:extension",
            :path => ":rails_root/public/spree/banner/:id/:style_:basename.:extension",
            #:default_url => "/missing/:style.jpg",
            :styles => {
                  :thumbnail => "80x80#",
                  :custom => Proc.new { |instance| "#{instance.attachment_width}x#{instance.attachment_height}#" }
            },
            :convert_options => {
                  :thumbnail => "-gravity center",
                  :custom => "-gravity center"
            }
  
  
  after_post_process :find_dimensions
  validates_presence_of :category, :attachment_width, :attachment_height
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], :message => "deve essere JPG, JPEG, PNG o GIF"
  
  scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }
  
  def initialize(*args)
    super(*args)
    last_banner = Banner.last
    self.position = last_banner ? last_banner.position + 1 : 0
  end
  
  def find_dimensions
    temporary = attachment.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end
end
