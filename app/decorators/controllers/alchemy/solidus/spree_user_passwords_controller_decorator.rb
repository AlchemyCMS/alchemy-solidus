# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeUserPasswordsControllerDecorator
      def self.prepended(base)
        base.include Alchemy::ControllerActions
      end

      if defined?(::Spree::UserPasswordsController)
        ::Spree::UserPasswordsController.prepend self
      end
    end
  end
end
