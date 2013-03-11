module Spree
  module BannersHelper

    def insert_banner(params={})
      params[:max] ||= 1
      params[:category] ||= "home"
      params[:class] ||= "banner"
      params[:style] ||= "small"
      params[:list] ||= false
      banner = Spree::Banner.enable(params[:category]).limit(params[:max])
      if !banner.blank?
        banner = banner.sort_by { |ban| ban.position }
        
        if (params[:list])
          content_tag(:ul, banner.map{|ban| content_tag(:li, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe )
        else
          banner.map{|ban| content_tag(:div, link_to(image_tag(ban.attachment.url(params[:style].to_sym)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe
        end
        
      end
    end
    
  end
end
