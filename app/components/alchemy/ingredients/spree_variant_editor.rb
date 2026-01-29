# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeVariantEditor < BaseEditor
      delegate :variant, to: :ingredient

      def input_field
        render Alchemy::Admin::VariantSelect.new(api_key, variant:, query_params:) do
          text_field_tag form_field_name(:variant_id),
            variant&.id,
            id: form_field_id(:variant_id),
            class: "full_width"
        end
      end

      private

      def api_key = helpers.current_alchemy_user&.spree_api_key
      def query_params = settings[:query_params]
    end
  end
end
