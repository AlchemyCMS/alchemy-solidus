# frozen_string_literal: true

module Alchemy
  class EssenceSpreeTaxon < ActiveRecord::Base
    TAXON_ID = /\A\d+\z/

    belongs_to :taxon,
      class_name: "Spree::Taxon",
      optional: true,
      foreign_key: "taxon_id"

    acts_as_essence(ingredient_column: :taxon)

    def ingredient=(taxon_or_id)
      case taxon_or_id
      when TAXON_ID
        self.taxon_id = taxon_or_id
      when Spree::Taxon
        self.taxon = taxon_or_id
      else
        super
      end
    end

    def preview_text(_maxlength)
      return unless taxon
      taxon.name
    end
  end
end
