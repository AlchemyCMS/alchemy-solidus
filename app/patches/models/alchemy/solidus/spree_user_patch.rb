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

      if defined?(::Spree::User)
        ::Spree::User.prepend self
        ::Spree::User.include Alchemy::UserMethods
      end
    end
  end
end
