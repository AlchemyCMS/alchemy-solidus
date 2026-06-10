# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeTaxonPatch
      def self.prepended(base)
        base.has_many :alchemy_ingredients, class_name: "Alchemy::Ingredients::SpreeTaxon", as: :related_object, dependent: :nullify
      end

      ::Spree::Taxon.prepend self
    end
  end
  ::Spree::Taxon.include RelatableResource
end
