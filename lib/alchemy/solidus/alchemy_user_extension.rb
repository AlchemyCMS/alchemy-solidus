module Alchemy
  module Solidus
    module AlchemyUserExtension
      def spree_roles
        if admin?
          ::Spree::Role.where(name: 'admin')
        else
          ::Spree::Role.none
        end
      end
    end
  end
end
