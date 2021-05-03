# frozen_string_literal: true

require "rails_helper"
require "alchemy/test_support/essence_shared_examples"

require_dependency "alchemy/site"

RSpec.describe Alchemy::EssenceSpreeProduct, type: :model do
  let(:product) { build_stubbed(:product) }
  let(:essence) { described_class.new(product: product) }

  it_behaves_like "an essence" do
    let(:ingredient_value) { product }
  end

  describe "ingredient=" do
    context "when String value is only a number" do
      let(:value) { "101" }

      before do
        essence.ingredient = value
      end

      it "sets spree_product_id with that id" do
        expect(essence.spree_product_id).to eq(101)
      end
    end

    context "when value is an Spree Variant" do
      let(:value) { product }

      before do
        essence.ingredient = value
      end

      it "sets product to that product" do
        expect(essence.product).to eq(product)
      end
    end

    context "when value is not only a number" do
      let(:value) { "product1" }

      it do
        expect {
          essence.ingredient = value
        }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
    end
  end

  describe "#preview_text" do
    subject { essence.preview_text(nil) }

    it "returns the products name" do
      is_expected.to eq(product.name)
    end
  end
end
