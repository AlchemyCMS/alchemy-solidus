module Alchemy
  module Solidus
    # Finds a Spree::Product by its slug.
    #
    module ProductFinder
      extend self

      # @param url [String] The URL to find the product by.
      # @return [Spree::Product, nil] The found product or nil if not found.
      def call(url)
        slug = url&.match(/products\/(?<slug>[\w-]+)/)&.captures
        return unless slug

        Spree::Product.find_by(slug:)
      end
    end
  end
end
