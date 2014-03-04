module Alchemy
  class EssenceSpreeTaxon < ActiveRecord::Base
    belongs_to :taxon, class_name: "Spree::Taxon", foreign_key: 'taxon_id', readonly: true

    acts_as_essence(
      ingredient_column: 'taxon_id',
      preview_text_method: 'name'
    )

    def ingredient
      taxon
    end
  end
end
