module Alchemy
  module Solidus
    class Ability
      include CanCan::Ability

      def initialize(user)
        if user && user.alchemy_roles.include?('admin')
          can :index, :alchemy_admin_solidus
        end
      end
    end
  end
end
