module Alchemy
  module Solidus
    class ProductPage < ActiveRecord::Base
      self.table_name = :alchemy_solidus_product_pages

      belongs_to :product, class_name: 'Spree::Product', inverse_of: :product_page
      belongs_to :page, class_name: 'Alchemy::Page', inverse_of: :product_page
    end
  end
end
