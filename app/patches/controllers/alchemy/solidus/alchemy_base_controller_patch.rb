# frozen_string_literal: true

module Alchemy
  module Solidus
    module AlchemyBaseControllerPatch
      def self.prepended(base)
        base.include Spree::Core::ControllerHelpers::Auth
        base.include Spree::Core::ControllerHelpers::Common
        base.include Spree::Core::ControllerHelpers::Order
        base.include Spree::Core::ControllerHelpers::PaymentParameters
        base.include Spree::Core::ControllerHelpers::Pricing
        base.include Spree::Core::ControllerHelpers::Search
        base.include Spree::Core::ControllerHelpers::Store
        base.include Spree::Core::ControllerHelpers::StrongParameters
      end

      if defined?(::Alchemy::BaseController)
        ::Alchemy::BaseController.prepend self
      end
    end
  end
end
