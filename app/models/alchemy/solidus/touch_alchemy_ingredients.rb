# frozen_string_literal: true

module Alchemy
  module Solidus
    module TouchAlchemyIngredients
      extend ActiveSupport::Concern

      included do
        after_update :touch_alchemy_ingredients
        after_touch :touch_alchemy_ingredients
      end

      private

      def touch_alchemy_ingredients
        alchemy_ingredients.each(&:touch)
      end
    end
  end
end
