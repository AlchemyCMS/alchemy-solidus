# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spree::Variant, type: :model do
  it { is_expected.to have_many(:alchemy_ingredients) }

  describe "cache invalidation" do
    let(:page) { create(:alchemy_page) }
    let(:page_version) { create(:alchemy_page_version, page: page) }
    let(:element) { create(:alchemy_element, page_version: page_version) }
    let!(:ingredient) { Alchemy::Ingredients::SpreeVariant.create!(element: element, role: "variant", related_object: variant) }
    let(:variant) { create(:variant) }

    it "invalidates the cache on update" do
      expect {
        variant.update!(sku: "New sku")
      }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeVariant", variant.id).and(
        enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeProduct", variant.product.id)
      )
    end

    it "invalidates the cache on touch" do
      expect {
        variant.touch
      }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeVariant", variant.id).and(
        enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeProduct", variant.product.id)
      )
    end
  end
end
