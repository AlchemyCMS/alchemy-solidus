# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeProduct < Alchemy::Ingredient
      related_object_alias :product, class_name: "Spree::Product"

      def preload_relations
        [{ taxons: :taxonomy }, { master: :images }]
      end

      def preview_text(maxlength)
        return unless product

        product.name[0..maxlength - 1]
      end
    end
  end
end
