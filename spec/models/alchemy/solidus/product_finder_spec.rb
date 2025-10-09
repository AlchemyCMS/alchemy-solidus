require "rails_helper"

RSpec.describe Alchemy::Solidus::ProductFinder do
  let(:product) { create(:product) }
  let(:finder) { described_class.call(url) }

  context "with url matching product slug" do
    let(:url) do
      Spree::Core::Engine.routes.url_helpers.product_path(product)
    end

    it "returns product" do
      expect(finder).to eq(product)
    end
  end

  context "with non matching url" do
    let(:url) { "some/product/22" }

    it "returns nil" do
      expect(finder).to be_nil
    end
  end

  context "with nil as url" do
    let(:url) { nil }

    it "returns nil" do
      expect(finder).to be_nil
    end
  end
end
