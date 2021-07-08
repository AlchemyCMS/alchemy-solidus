# frozen_string_literal: true

module Alchemy
  module Ingredients
    class SpreeTaxon < Alchemy::Ingredient
      related_object_alias :taxon, class_name: "Spree::Taxon"

      def preview_text(maxlength)
        return unless taxon

        taxon.name[0..maxlength - 1]
      end
    end
  end
end
