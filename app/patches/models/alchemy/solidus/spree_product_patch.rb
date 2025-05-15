# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeProductPatch
      def self.prepended(base)
        # Solidus runs touch callbacks on product after_save
        base.after_touch :touch_alchemy_ingredients
        base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeProduct", as: :related_object, dependent: :nullify
      end

      private

      # Overwritten Solidus' default behavior
      #
      # The Solidus implementation did not trigger `touch` on taxons, but
      # updated the `updated_at` timestamp in an `update_all`.
      #
      # Since we want to invalidate ingredient spree taxons cache as well
      # we need to use `touch` here and use the `after_touch` callback of
      # Spree::Taxon
      #
      def touch_taxons
        taxons.each(&:touch)
      end

      # Touch all elements that have this product assigned to one of its ingredients.
      # This cascades to all parent elements and pages as well.
      def touch_alchemy_ingredients
        InvalidateElementsCacheJob.perform_later("SpreeProduct", id)
      end

      ::Spree::Product.prepend self
    end
  end
end
