# frozen_string_literal: true

module Alchemy
  module Solidus
    module ApplicationControllerPatch
      def spree_current_user
        if Alchemy.user_class_name == "::Alchemy::User"
          current_user
        else
          super
        end
      end

      if defined?(::ApplicationController)
        ::ApplicationController.prepend self
      end
    end
  end
end
