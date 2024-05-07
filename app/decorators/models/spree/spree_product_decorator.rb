# frozen_string_literal: true

module Spree
  module SpreeProductDecorator
    def self.prepended(base)
      base.include AlchemySolidus::TouchAlchemyIngredients
      base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeProduct", as: :related_object, dependent: :nullify
    end

    ::Spree::Product.prepend self
  end
end
