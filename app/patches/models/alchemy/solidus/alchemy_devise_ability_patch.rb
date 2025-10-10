# frozen_string_literal: true

module Alchemy
  module Solidus
    module AlchemyDeviseAbilityPatch
      def initialize(user)
        super

        # Without these abilities, Alchemy's signup page does not work with Solidus' UsersController.
        if Alchemy::User.count == 0
          can :admin, Alchemy::User
          can :update_password, Alchemy::User
          can :update_email, Alchemy::User
        end
      end

      if defined?(::Alchemy::Devise::Ability)
        ::Alchemy::Devise::Ability.prepend self
      end
    end
  end
end
