# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeProductView < BaseView
      delegate :product, to: :ingredient

      def call
        product.name
      end

      def render?
        !!product
      end
    end
  end
end
