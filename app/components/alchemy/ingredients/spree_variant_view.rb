# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeVariantView < BaseView
      delegate :variant, to: :ingredient

      def call
        variant.name
      end

      def render?
        !!variant
      end
    end
  end
end
