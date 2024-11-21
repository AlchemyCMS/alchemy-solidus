# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeUserRegistrationsControllerPatch
      def self.prepended(base)
        base.include Alchemy::ControllerActions
      end

      if defined?(::Spree::UserRegistrationsController)
        ::Spree::UserRegistrationsController.prepend self
      end
    end
  end
end
