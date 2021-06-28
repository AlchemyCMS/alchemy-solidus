# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeTaxon < Alchemy::Ingredient
      related_object_alias :taxon, class_name: "Spree::Taxon"
    end
  end
end
