module Alchemy
  module Solidus
    module AlchemyUserPatch
      def self.prepended(klass)
        klass.include Spree::UserMethods
      end

      def spree_roles
        if admin?
          ::Spree::Role.where(name: "admin")
        else
          ::Spree::Role.none
        end
      end

      if defined?(::Alchemy::User)
        ::Alchemy::User.prepend self
      end
    end
  end
end
