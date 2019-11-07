# frozen_string_literal: true

module Alchemy
  class EssenceSpreeVariant < ActiveRecord::Base
    VARIANT_ID = /\A\d+\z/

    belongs_to :variant, class_name: 'Spree::Variant', optional: true

    acts_as_essence(
      ingredient_column: :variant,
      preview_text_method: :name
    )

    def ingredient=(variant)
      case variant
      when VARIANT_ID
        self.variant = Spree::Variant.new(id: variant)
      when Spree::Variant
        self.variant = variant
      else
        super
      end
    end
  end
end
