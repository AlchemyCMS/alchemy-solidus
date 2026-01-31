# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeProductEditor < BaseEditor
      delegate :product, to: :ingredient

      def input_field
        render Alchemy::Admin::ProductSelect.new(api_key, product:, query_params:) do
          text_field_tag form_field_name(:product_id),
            product&.id,
            id: form_field_id(:product_id),
            class: "full_width"
        end
      end

      private

      def api_key = helpers.current_alchemy_user&.spree_api_key
      def query_params = settings[:query_params]
    end
  end
end
