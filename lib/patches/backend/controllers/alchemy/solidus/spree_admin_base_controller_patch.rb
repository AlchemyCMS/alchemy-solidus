# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeAdminBaseControllerPatch
      def self.prepended(base)
        if Alchemy.user_class_name == "::Alchemy::User"
          base.unauthorized_redirect = -> do
            if spree_current_user
              flash[:error] = I18n.t("spree.authorization_failure")
              redirect_to spree.root_path
            else
              store_location
              redirect_to Alchemy.login_path
            end
          end
        end
      end

      if defined?(::Spree::Admin::BaseController)
        ::Spree::Admin::BaseController.prepend self
      end
    end
  end
end
