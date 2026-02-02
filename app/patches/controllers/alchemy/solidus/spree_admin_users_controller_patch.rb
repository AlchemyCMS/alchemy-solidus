# /home/anselm/code/alchemy-solidus/app/patches/controllers/alchemy/solidus/spree_admin_users_controller_patch.rb

module Alchemy
  module Solidus
    module SpreeAdminUsersControllerPatch
      def self.prepended(base)
        base.after_action :assign_admin_roles_to_first_user, only: :create
      end

      private

      def assign_admin_roles_to_first_user
        if Spree.user_class.count == 1
          user = Spree.user_class.last
          user.spree_roles = [Spree::Role.find_or_create_by(name: "admin")]
          user.alchemy_roles = ["admin"]
          user.save
        end
      end
    end
  end
end

::Spree::Admin::UsersController.prepend(Alchemy::Solidus::SpreeAdminUsersControllerPatch)
