module Alchemy
  module Solidus
    module SpreeProductExtension
      def self.included(base)
        base.has_one :product_page, class_name: 'Alchemy::Solidus::ProductPage', inverse_of: :product
        base.has_one :alchemy_page, through: :product_page, source: :page
      end

      def product_page
        Alchemy::Solidus::ProductPage.find_by(product: self) || create_product_page!
      end

      def alchemy_page
        product_page.page || create_alchemy_page!
      end

      private

      def create_alchemy_page!
        product_page.create_page!(
          parent: alchemy_language_root_page,
          page_layout: 'product_page',
          name: name
        )
      end

      def alchemy_language_root_page
        language = Alchemy::Language.current
        language.root_page || Alchemy::Page.create!(
          page_layout: language.page_layout,
          name: language.frontpage_name,
          parent: Alchemy::Page.root
        )
      end
    end
  end
end

Spree::Product.include(Alchemy::Solidus::SpreeProductExtension)
