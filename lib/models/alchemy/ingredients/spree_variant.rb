# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeVariant < Alchemy::Ingredient
      related_object_alias :variant, class_name: "Spree::Variant"

      def preview_text(maxlength)
        return unless variant

        variant.descriptive_name[0..maxlength - 1]
      end
    end
  end
end
