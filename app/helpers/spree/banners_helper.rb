module Spree
  module BannersHelper

    def insert_banner(params={})
      # max items show for list
      params[:max] ||= 1
      # category items show
      params[:category] ||= "home"
      # class items show
      params[:class] ||= "banner"
      # style items show
      params[:list] ||= false
      banner = Spree::Banner.enable(params[:category]).limit(params[:max])
      if !banner.blank?
        banner = banner.sort_by { |ban| ban.position }
        
        if (params[:list])
          content_tag(:ul, banner.map{|ban| content_tag(:li, link_to(image_tag(ban.attachment.url(:custom)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe )
        else
          banner.map{|ban| content_tag(:div, link_to(image_tag(ban.attachment.url(:custom)), (ban.url.blank? ? "javascript: void(0)" : ban.url)), :class => params[:class])}.join().html_safe
        end
        
      end
    end
    
  end
end
