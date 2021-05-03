# frozen_string_literal: true

module Alchemy
  class EssenceSpreeProduct < ActiveRecord::Base
    PRODUCT_ID = /\A\d+\z/

    belongs_to :product,
      class_name: "Spree::Product",
      optional: true,
      foreign_key: "spree_product_id"

    acts_as_essence(ingredient_column: :product)

    def ingredient=(product_or_id)
      case product_or_id
      when PRODUCT_ID, ""
        self.spree_product_id = product_or_id
      when Spree::Product
        self.product = product_or_id
      else
        super
      end
    end

    def preview_text(_maxlength)
      return unless product
      product.name
    end
  end
end
