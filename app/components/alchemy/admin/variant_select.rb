module Alchemy
  module Admin
    class VariantSelect < ViewComponent::Base
      delegate :spree, to: :helpers

      attr_reader :api_key, :variant, :url, :query_params, :placeholder

      def initialize(api_key, variant: nil, url: nil, query_params: nil, placeholder: nil)
        @api_key = api_key
        @variant = variant
        @url = url
        @query_params = query_params
        @placeholder = placeholder
      end

      def call
        content_tag("alchemy-variant-select", content, attributes)
      end

      private

      def attributes
        attrs = {
          url: url || spree.api_variants_path,
          placeholder: placeholder || Alchemy.t(:search_variant, scope: :solidus),
          "api-key": api_key
        }

        attrs[:"query-params"] = query_params.to_json if query_params

        if variant
          attrs[:selection] = serialized_selection
        end

        attrs
      end

      def serialized_selection
        {
          id: variant.id,
          name: variant.name,
          sku: variant.sku,
          options_text: variant.options_text
        }.to_json
      end
    end
  end
end
