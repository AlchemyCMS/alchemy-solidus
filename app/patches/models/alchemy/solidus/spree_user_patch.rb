# frozen_string_literal: true

module Alchemy
  module Solidus
    module SpreeUserPatch
      def self.prepended(base)
        base.has_many :folded_pages, class_name: "Alchemy::FoldedPage"
      end

      def alchemy_display_name
        email
      end

      def alchemy_roles
        if has_spree_role?(:admin)
          %w[admin]
        else
          []
        end
      end

      if defined?(::Spree::User)
        ::Spree::User.prepend self
      end
    end
  end
end
