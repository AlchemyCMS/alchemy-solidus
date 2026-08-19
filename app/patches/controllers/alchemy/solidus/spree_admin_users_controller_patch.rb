# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeAdminUsersControllerPatch
      private

      def permitted_user_attributes
        attributes = super
        attributes << {alchemy_roles: []} if can?(:update_role, @user)
        attributes
      end

      if defined?(::Spree::Admin::UsersController)
        ::Spree::Admin::UsersController.prepend self
      end
    end
  end
end
