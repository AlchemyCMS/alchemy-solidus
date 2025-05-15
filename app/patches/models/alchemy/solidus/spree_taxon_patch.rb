# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeTaxonPatch
      def self.prepended(base)
        base.after_update :touch_alchemy_ingredients
        base.after_touch :touch_alchemy_ingredients
        base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeTaxon", as: :related_object, dependent: :nullify
      end

      ::Spree::Taxon.prepend self

      private

      # Touch all elements that have this taxon assigned to one of its ingredients.
      # This cascades to all parent elements and pages as well.
      def touch_alchemy_ingredients
        InvalidateElementsCacheJob.perform_later("SpreeTaxon", id)
      end
    end
  end
end
