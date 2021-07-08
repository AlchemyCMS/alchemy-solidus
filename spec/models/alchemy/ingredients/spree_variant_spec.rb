# frozen_string_literal: true

require "alchemy/version"

if Alchemy.gem_version >= Gem::Version.new("6.0.0.b1")
  require "rails_helper"
  require "alchemy/test_support/shared_ingredient_examples"

  RSpec.describe Alchemy::Ingredients::SpreeVariant, type: :model do
    let(:variant) { build_stubbed(:variant) }
    let(:ingredient) { described_class.new(variant: variant) }

    it_behaves_like "an alchemy ingredient"

    describe "#variant" do
      subject { ingredient.variant }

      it "returns the variant" do
        is_expected.to eq(variant)
      end

      context "without variant" do
        let(:variant) { nil }

        it { is_expected.to be_nil }
      end
    end

    describe "#preview_text" do
      subject { ingredient.preview_text(30) }

      it "returns the variants name" do
        is_expected.to eq(variant.descriptive_name)
      end

      context "without variant" do
        let(:variant) { nil }

        it { is_expected.to be_nil }
      end
    end
  end
end
