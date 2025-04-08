# frozen_string_literal: true

module Alchemy
  module Admin
    module LinkDialog
      class ProductTab < BaseTab
        delegate :alchemy, :current_alchemy_user, :spree, to: :helpers

        def self.product_select_class
          ProductSelect
        end

        def title
          Alchemy.t("link_overlay_tab_label.product")
        end

        def self.panel_name
          :product
        end

        def fields
          [
            product_select,
            title_input,
            target_select
          ]
        end

        def message
          render_message(:info, content_tag("h3", Alchemy.t(:choose_product_to_link)))
        end

        private

        def product
          slug = url&.match(/products\/(?<slug>[\w-]+)/)&.captures
          return unless slug

          @_product ||= Spree::Product.find_by(slug: slug)
        end

        def product_select
          label = label_tag("product_link", Alchemy.t(:product), class: "control-label")
          input = text_field_tag("product_link", product && url, id: "product_link",
            placeholder: Alchemy.t(:search_product, scope: "solidus"),
            class: "alchemy_selectbox")
          select = render self.class.product_select_class.new(
            current_alchemy_user.spree_api_key,
            product: product,
            url: spree.api_products_path,
            value_attribute: :slug
          ).with_content(input)
          content_tag("div", label + select, class: "input select")
        end
      end
    end
  end
end
