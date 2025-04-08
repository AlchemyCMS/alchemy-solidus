module Alchemy
  module Admin
    class ProductSelect < ViewComponent::Base
      VALUE_ATTRIBUTES = %i[id slug].freeze

      delegate :spree, to: :helpers

      attr_reader :api_key, :product, :url, :query_params, :placeholder

      def initialize(api_key, product: nil, url: nil, query_params: nil, placeholder: nil, value_attribute: nil)
        @api_key = api_key
        @product = product
        @url = url
        @query_params = query_params
        @placeholder = placeholder
        @value_attribute = value_attribute
      end

      def call
        content_tag("alchemy-product-select", content, attributes)
      end

      private

      def value_attribute
        @value_attribute.in?(VALUE_ATTRIBUTES) ? @value_attribute : :id
      end

      def attributes
        attrs = {
          placeholder: placeholder || Alchemy.t(:search_product, scope: "solidus"),
          url: url || spree.api_products_path,
          "value-attribute": value_attribute,
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
          id: product.send(value_attribute),
          name: product.name
        }.to_json
      end
    end
  end
end
