# frozen_string_literal: true

require "alchemy/version"

if Alchemy.gem_version >= Gem::Version.new("6.0.0.b1")
  require "rails_helper"
  require "alchemy/test_support/shared_ingredient_examples"

  RSpec.describe Alchemy::Ingredients::SpreeProduct, type: :model do
    let(:product) { build_stubbed(:product) }
    let(:ingredient) { described_class.new(product: product) }

    it_behaves_like "an alchemy ingredient"

    describe "#product" do
      subject { ingredient.product }

      it "returns the product" do
        is_expected.to eq(product)
      end

      context "without product" do
        let(:product) { nil }

        it { is_expected.to be_nil }
      end
    end

    describe "#preview_text" do
      subject { ingredient.preview_text(30) }

      it "returns the products name" do
        is_expected.to eq(product.name)
      end

      context "without product" do
        let(:product) { nil }

        it { is_expected.to be_nil }
      end
    end

    describe "#preload_relations" do
      subject { ingredient.preload_relations }

      it { is_expected.to eq([{ taxons: :taxonomy }, { master: :images }]) }
    end
  end
end
