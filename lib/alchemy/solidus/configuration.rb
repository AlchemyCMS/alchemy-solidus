# frozen_string_literal: true

require "alchemy/configuration"

module Alchemy
  module Solidus
    class Configuration < Alchemy::Configuration
      # == This is the Alchemy Solidus configuration class

      # === Product URL Attribute
      #
      # The Spree::Product attribute we use for url.
      #
      # NOTE: Used in the Product Select.
      #
      option :product_url_attribute, :string, default: "url_path"

      # === Product URL Finder
      #
      # The class responsible to load the product by url.
      #
      # NOTE: Used in the Page Link Dialogs Product Tab.
      #
      option :product_finder, :class, default: "Alchemy::Solidus::ProductFinder"
    end
  end
end
