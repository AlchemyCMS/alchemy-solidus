# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeTaxonEditor < BaseEditor
      delegate :taxon, to: :ingredient

      def input_field
        render Alchemy::Admin::TaxonSelect.new(api_key, taxon:, query_params:) do
          text_field_tag form_field_name(:taxon_id),
            taxon&.id,
            id: form_field_id(:taxon_id),
            class: "full_width"
        end
      end

      private

      def api_key = helpers.current_alchemy_user&.spree_api_key
      def query_params = settings[:query_params]
    end
  end
end
