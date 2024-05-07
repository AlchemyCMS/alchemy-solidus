# frozen_string_literal: true

module Spree
  module SpreeTaxonDecorator
    def self.prepended(base)
      base.include AlchemySolidus::TouchAlchemyIngredients
      base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeTaxon", as: :related_object, dependent: :nullify
    end

    ::Spree::Taxon.prepend self
  end
end
