# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spree::Product, type: :model do
  it { is_expected.to have_many(:alchemy_ingredients) }

  describe "#url_path" do
    let(:product) { create(:product) }

    it "returns the product path" do
      expect(product.url_path).to eq(Spree::Core::Engine.routes.url_helpers.product_path(product))
    end
  end

  describe "cache invalidation" do
    let(:page) { create(:alchemy_page) }
    let(:page_version) { create(:alchemy_page_version, page: page) }
    let(:element) { create(:alchemy_element, page_version: page_version) }
    let(:product) { create(:product) }

    context "if assigned to ingredient spree product" do
      let!(:ingredient) { Alchemy::Ingredients::SpreeProduct.create!(element: element, role: "product", related_object: product) }

      it "invalidates the cache on update" do
        expect {
          product.update!(name: "New name")
        }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeProduct", product.id)
      end

      it "invalidates the cache on touch" do
        expect {
          product.touch
        }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeProduct", product.id)
      end
    end

    context "if assigned to taxon that is assigned to ingredient spree taxon" do
      let(:taxon) { create(:taxon) }
      let!(:product) { create(:product, taxons: [taxon]) }

      let!(:ingredient) { Alchemy::Ingredients::SpreeTaxon.create!(element: element, role: "taxon", related_object: taxon) }

      it "touches ingredient spree taxons elements" do
        expect {
          product.touch
        }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeTaxon", taxon.id).and(
          enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeProduct", product.id)
        )
      end
    end
  end
end
