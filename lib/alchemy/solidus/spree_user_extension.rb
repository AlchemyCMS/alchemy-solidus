module Alchemy
  module Solidus
    module SpreeUserExtension
      def alchemy_roles
        if has_spree_role?(:admin)
          %w(admin)
        else
          []
        end
      end
    end
  end
end
