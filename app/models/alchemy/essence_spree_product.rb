module Alchemy
  class EssenceSpreeProduct < ActiveRecord::Base
    belongs_to :product, class_name: "Spree::Product", foreign_key: 'spree_product_id', readonly: true

    acts_as_essence(
      ingredient_column: 'spree_product_id',
      preview_text_method: 'name'
    )

    def ingredient
      product
    end
  end
end
