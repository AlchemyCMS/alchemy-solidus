# frozen_string_literal: true

require "rails_helper"

RSpec.describe "alchemy/essences/_essence_spree_product_editor" do
  let(:content) do
    content = Alchemy::Content.new(essence: essence)
    if Alchemy.gem_version >= Gem::Version.new("4.9")
      Alchemy::ContentEditor.new(content)
    else
      content
    end
  end

  let(:essence) { Alchemy::EssenceSpreeProduct.new }

  before do
    view.class.send(:include, Alchemy::Admin::ElementsHelper)
    expect(view).to receive(:content_label) { content.name }
  end

  context "with local named content" do
    subject do
      render "alchemy/essences/essence_spree_product_editor",
        content: content,
        spree: double(api_products_path: "/api/products"),
        current_alchemy_user: double(spree_api_key: "123")
      rendered
    end

    it "renders a product input" do
      is_expected.to have_css("input.alchemy_selectbox.full_width")
    end

    context "with a product related to essence" do
      let(:product) { Spree::Product.new(id: 1) }
      let(:essence) { Alchemy::EssenceSpreeProduct.new(spree_product_id: product.id) }

      it "sets product id as value" do
        is_expected.to have_css('input.alchemy_selectbox[value="1"]')
      end
    end
  end

  context "with local named essence_spree_product_editor" do
    subject do
      render "alchemy/essences/essence_spree_product_editor",
        essence_spree_product_editor: content,
        spree: double(api_products_path: "/api/products"),
        current_alchemy_user: double(spree_api_key: "123")
      rendered
    end

    it "renders a product input" do
      is_expected.to have_css("input.alchemy_selectbox.full_width")
    end

    context "with a product related to essence" do
      let(:product) { Spree::Product.new(id: 1) }
      let(:essence) { Alchemy::EssenceSpreeProduct.new(spree_product_id: product.id) }

      it "sets product id as value" do
        is_expected.to have_css('input.alchemy_selectbox[value="1"]')
      end
    end
  end
end
