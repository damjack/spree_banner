module Spree
  module BannerBoxesHelper

    def insert_banner_box(params={})
      params[:category] ||= "home"
      params[:class] ||= "banner"
      params[:style] ||= "small"
      params[:list] ||= false
      @@banner = Spree::BannerBox.enable(params[:category])
      if @@banner.blank?
        return ''
      end
      res = []
      banner = @@banner.sort_by { |ban| ban.position }
        
      if (params[:list])
        content_tag(:ul, banner.map{|ban| content_tag(:li, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe )
      else
        banner.map{|ban| content_tag(:div, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe
      end
    end
    
  end
end
