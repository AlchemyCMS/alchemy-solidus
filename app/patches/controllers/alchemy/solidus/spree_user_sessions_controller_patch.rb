# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeUserSessionsControllerPatch
      def self.prepended(base)
        base.include Alchemy::ControllerActions
      end

      if defined?(::Spree::UserSessionsController)
        ::Spree::UserSessionsController.prepend self
      end
    end
  end
end
