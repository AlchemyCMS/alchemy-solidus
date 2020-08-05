module Alchemy
  module Solidus
    module SpreeUserExtension
      def self.included(klass)
        klass.has_many :folded_pages, class_name: "Alchemy::FoldedPage"
      end

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
