module Alchemy
  module Admin
    class TaxonSelect < ViewComponent::Base
      delegate :spree, to: :helpers

      attr_reader :api_key, :taxon, :url, :query_params, :placeholder

      def initialize(api_key, taxon: nil, url: nil, query_params: nil, placeholder: nil)
        @api_key = api_key
        @taxon = taxon
        @url = url
        @query_params = query_params
        @placeholder = placeholder
      end

      def call
        content_tag("alchemy-taxon-select", content, attributes)
      end

      private

      def attributes
        attrs = {
          url: url || spree.api_taxons_path,
          placeholder: placeholder || Alchemy.t(:search_taxon, scope: :solidus),
          "api-key": api_key
        }

        attrs[:"query-params"] = query_params.to_json if query_params

        if taxon
          attrs[:selection] = serialized_selection
        end

        attrs
      end

      def serialized_selection
        {
          id: taxon.id,
          text: taxon.pretty_name
        }.to_json
      end
    end
  end
end
