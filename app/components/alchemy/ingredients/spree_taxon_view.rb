# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeTaxonView < BaseView
      delegate :taxon, to: :ingredient

      def call
        taxon.name
      end

      def render?
        !!taxon
      end
    end
  end
end
