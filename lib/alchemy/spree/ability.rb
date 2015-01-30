module Alchemy
  module Spree
    class Ability
      include CanCan::Ability

      def initialize(user)
        if user && user.alchemy_roles.include?('admin')
          can :index, :alchemy_admin_spree
        end
      end
    end
  end
end
