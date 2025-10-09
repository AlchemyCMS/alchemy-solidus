# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Admin::LinkDialog::ProductTab, type: :component do
  let!(:product) { create(:product) }
  let(:url) { Spree::Core::Engine.routes.url_helpers.product_path(product) }

  let(:is_selected) { false }
  let(:link_title) { nil }
  let(:link_target) { nil }

  before do
    allow_any_instance_of(described_class).to receive(:current_alchemy_user).and_return(build(:alchemy_user))
    render_inline(described_class.new(url, is_selected: is_selected, link_title: link_title, link_target: link_target))
  end

  it_behaves_like "a link dialog tab", :product, "Product"
  it_behaves_like "a link dialog - target select", :product

  it "has a product select" do
    expect(page).to have_selector("alchemy-product-select [name=product_link]")
  end

  it "sets the value-attribute" do
    expect(page).to have_selector("alchemy-product-select[value-attribute=url_path]")
  end

  context "with product found by url" do
    it "has value set" do
      expect(page).to have_selector("alchemy-product-select [value='#{url}']")
    end
  end

  context "with product not found by url" do
    let(:url) { Alchemy::Engine.routes.url_helpers.show_page_path(urlname: "foo") }

    it "has no value set" do
      expect(page).to_not have_selector("alchemy-product-select [value='#{url}']")
    end
  end
end
