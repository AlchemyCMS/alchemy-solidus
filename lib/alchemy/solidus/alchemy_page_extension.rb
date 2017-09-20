module Alchemy
  module Solidus
    module AlchemyPageExtension
      def self.included(base)
        base.has_one :product_page, class_name: 'Alchemy::Solidus::ProductPage', inverse_of: :page
        base.has_one :spree_product, through: :product_page, source: :product
      end
    end
  end
end

Alchemy::Page.include(Alchemy::Solidus::AlchemyPageExtension)
