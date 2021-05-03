# frozen_string_literal: true

module Alchemy
  class EssenceSpreeVariant < ActiveRecord::Base
    VARIANT_ID = /\A\d+\z/

    belongs_to :variant,
      class_name: "Spree::Variant",
      optional: true

    acts_as_essence(ingredient_column: :variant)

    def ingredient=(variant_or_id)
      case variant_or_id
      when VARIANT_ID
        self.variant_id = variant_or_id
      when Spree::Variant
        self.variant = variant_or_id
      else
        super
      end
    end

    def preview_text(_maxlength)
      return unless variant
      variant.descriptive_name
    end
  end
end
