# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeVariantDecorator
      def self.prepended(base)
        base.include AlchemySolidus::TouchAlchemyIngredients
        base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeVariant", as: :related_object, dependent: :nullify
      end

      ::Spree::Variant.prepend self
    end
  end
end
