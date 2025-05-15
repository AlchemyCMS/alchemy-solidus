# frozen_string_literal: true

module Alchemy
  module Solidus
    module AlchemyBaseHelperPatch
      def self.prepended(base)
        base.include Spree::BaseHelper
        base.include Spree::CheckoutHelper
        base.include Spree::ProductsHelper
        base.include Spree::StoreHelper
        base.include Spree::TaxonsHelper
      end

      if defined?(::Alchemy::BaseHelper)
        ::Alchemy::BaseHelper.prepend self
      end
    end
  end
end
