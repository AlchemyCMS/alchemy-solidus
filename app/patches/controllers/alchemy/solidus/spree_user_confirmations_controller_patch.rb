# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeUserConfirmationsControllerPatch
      def self.prepended(base)
        base.include Alchemy::ControllerActions
      end

      if defined?(::Spree::UserConfirmationsController)
        ::Spree::UserConfirmationsController.prepend self
      end
    end
  end
end
