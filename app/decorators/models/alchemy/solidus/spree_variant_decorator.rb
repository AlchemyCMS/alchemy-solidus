# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeVariantDecorator
      def self.prepended(base)
        base.after_update :touch_alchemy_ingredients
        base.after_touch :touch_alchemy_ingredients
        base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeVariant", as: :related_object, dependent: :nullify
      end

      ::Spree::Variant.prepend self

      private

      # Touch all elements that have this variant assigned to one of its ingredients.
      # This cascades to all parent elements and pages as well.
      def touch_alchemy_ingredients
        InvalidateElementsCacheJob.perform_later("SpreeVariant", id)
      end
    end
  end
end
