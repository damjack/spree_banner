module Spree
  module Admin
    class BannersController < ResourceController
            
      def show
        redirect_to(:action => :edit)
      end
      
      def update_positions
        params[:positions].each do |id, index|
          Spree::Banner.where(:id => id).update_all(:position => index)
        end

        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
      end
      
      private
      def location_after_save
        edit_admin_banner_url(@banner)
      end
      
    end
  end
end
