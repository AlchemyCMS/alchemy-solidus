# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Admin::ProductSelect, type: :component do
  let(:api_key) { "123" }
  let(:url) { Spree::Core::Engine.routes.url_helpers.api_products_path }
  let(:product) { nil }
  let(:query_params) { nil }
  let(:placeholder) { nil }
  let(:value_attribute) { nil }

  before do
    render_inline(described_class.new(
      api_key,
      url: url,
      product: product,
      query_params: query_params,
      placeholder: placeholder,
      value_attribute: value_attribute
    ))
  end

  it "has a product select" do
    expect(page).to have_selector(
      "alchemy-product-select[api-key='#{api_key}'][url='#{url}']"
    )
  end

  context "with a product" do
    let(:product) { create(:product, name: "Product Name", slug: "product-name") }

    it "adds a selection" do
      expect(page).to have_selector(
        "alchemy-product-select[selection='{\"id\":#{product.id},\"name\":\"Product Name\"}']"
      )
    end
  end

  context "with query-params" do
    let(:query_params) { {available: true} }

    it "adds a selection" do
      expect(page).to have_selector(
        "alchemy-product-select[query-params='{\"available\":true}']"
      )
    end
  end

  context "with placeholder" do
    let(:placeholder) { "Foo Bar" }

    it "adds a placeholder" do
      expect(page).to have_selector(
        "alchemy-product-select[placeholder='Foo Bar']"
      )
    end
  end

  context "with value_attribute set to slug" do
    let(:value_attribute) { :slug }

    it "sets value-attribute to 'slug'" do
      expect(page).to have_selector(
        "alchemy-product-select[value-attribute='slug']"
      )
    end
  end

  context "with value_attribute set to nil" do
    let(:value_attribute) { nil }

    it "sets value-attribute to 'id'" do
      expect(page).to have_selector(
        "alchemy-product-select[value-attribute='id']"
      )
    end
  end
end
