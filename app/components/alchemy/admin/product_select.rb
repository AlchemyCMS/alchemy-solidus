module Alchemy
  module Admin
    class ProductSelect < ViewComponent::Base
      delegate :spree, to: :helpers

      attr_reader :api_key, :product, :url, :query_params

      def initialize(api_key, product: nil, url: nil, query_params: nil)
        @api_key = api_key
        @product = product
        @url = url
        @query_params = query_params
      end

      def call
        content_tag("alchemy-product-select", content, attributes)
      end

      private

      def attributes
        attrs = {
          url: url || spree.api_products_path,
          "api-key": api_key
        }

        attrs[:"query-params"] = query_params.to_json if query_params

        if product
          attrs[:selection] = serialized_selection
        end

        attrs
      end

      def serialized_selection
        {
          name: product.name,
          slug: product.slug
        }.to_json
      end
    end
  end
end
