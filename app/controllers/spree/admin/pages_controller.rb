module Spree
  module Admin
    class PagesController < ResourceController
      def edit
        @product = model_class.find_by!(slug: params[:product_id])
      end

      private

      def model_class
        Spree::Product
      end
    end
  end
end
