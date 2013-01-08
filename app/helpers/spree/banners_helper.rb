module Spree
  module BannersHelper

    def insert_banner(params={})
      # max items show for list
      max = params[:max] || 1
      # category items show
      category = params[:category] || ""
      # class items show
      cl = params[:class] || "banner"
      # style items show
      style = params[:style] || "list"
      banner = Banner.enable(category).limit(max)
      if !banner.blank?
        banner = banner.sort_by { |ban| ban.position }
        
        if (style == "list")
          content_tag(:ul, raw(banner.map do |ban| content_tag(:li, link_to(image_tag(ban.attachment.url(:custom)), ban.url), :class => cl) end.join) )
        else
          raw(banner.map do |ban| content_tag(style.to_sym, link_to(image_tag(ban.attachment.url(:custom)), ban.url), :class => cl) end.join)
        end
        
      end
    end
    
  end
end
