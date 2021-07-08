# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeVariant < Alchemy::Ingredient
      related_object_alias :variant, class_name: "Spree::Variant"
    end
  end
end
