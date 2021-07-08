# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeProduct < Alchemy::Ingredient
      related_object_alias :product, class_name: "Spree::Product"
    end
  end
end
