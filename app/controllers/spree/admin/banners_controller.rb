module Spree
  module Admin
    class BannersController < ResourceController
      before_filter :load_data
      
      
      def load_data
        @banners = Spree::Banner.all
      end
    end
  end
end
