module Spree
  class Banner < ActiveRecord::Base
  
    has_attached_file :attachment,
                :url  => "/spree/banner/:id/:style_:basename.:extension",
                :path => ":rails_root/public/spree/banner/:id/:style_:basename.:extension",
                #:default_url => "/missing/:style.jpg",
                :styles => {
                      :thumbnail => "80x80#",
                      :custom => Proc.new { |instance| "#{instance.attachment_width}x#{instance.attachment_height}#" }
                },
                :convert_options => {
                      :thumbnail => "-gravity center"
                }
    
    validates_presence_of :category, :attachment_width, :attachment_height
    validates_attachment_presence :attachment
    validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif'], :message => "deve essere JPG, JPEG o PNG"
    #process_in_background :image UTILE MA OCCORRE ATTIVARE ANCHE LA GEMMA DELAYED-PAPERCLIP
    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }

    def initialize(*args)
      super(*args)
      last_banner = Banner.last
      self.position = last_banner ? last_banner.position + 1 : 0
    end
    
  end
end
