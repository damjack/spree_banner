module Spree
  module Admin
    class BannerBoxesController < ResourceController
            
      def show
        redirect_to( :action => :edit )
      end
      
      private
      def location_after_save
        edit_admin_banner_box_url(@banner_box)
      end
    end
  end
end
