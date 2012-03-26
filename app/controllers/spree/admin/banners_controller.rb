module Spree
  module Admin
    class BannersController < ResourceController
      before_filter :load_data
      
      def update_positions
        params[:positions].each do |id, index|
          Spree::Banner.update_all(['position=?', index], ['id=?', id])
        end

        respond_to do |format|
          format.html { redirect_to admin_banners_url() }
          format.js  { render :text => 'Ok' }
        end
      end
      
      def load_data
        @banners = Spree::Banner.all
      end
      
      private
      def location_after_save
        admin_banners_url(@banner)
      end
      
    end
  end
end
