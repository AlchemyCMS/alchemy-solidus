# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeTaxonDecorator
      def self.prepended(base)
        base.include Alchemy::Solidus::TouchAlchemyIngredients
        base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeTaxon", as: :related_object, dependent: :nullify
      end

      ::Spree::Taxon.prepend self
    end
  end
end
