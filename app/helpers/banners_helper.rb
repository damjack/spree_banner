module BannersHelper
  
  def insert_banner(params={})
    max = params[:max] || 1
    category = params[:category] || ""
    banner = Banner.enable(category).limit(max)
    if !banner.blank?
      banner = banner.sort_by { |ban| ban.position }

      content_tag(:div, content_tag(:ul, banner.map do |ban| content_tag(:li, link_to(image_tag(ban.attachment.url(:custom)), ban.url, { :title => ban.title })) end.join ), :class => "banner")
    end
  end
  
end
