# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeStoreControllerPatch
      # Allows to render Alchemy content within Solidus' controller views
      def self.prepended(base)
        base.include Alchemy::ControllerActions
        base.include Alchemy::ConfigurationMethods
      end

      if defined?(::Spree::StoreController)
        ::Spree::StoreController.prepend self
      end
    end
  end
end
