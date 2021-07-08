# frozen_string_literal: true

require "alchemy/version"

if Alchemy.gem_version >= Gem::Version.new("6.0.0.b1")
  require "rails_helper"
  require "alchemy/test_support/shared_ingredient_examples"

  RSpec.describe Alchemy::Ingredients::SpreeTaxon, type: :model do
    let(:taxon) { build_stubbed(:taxon) }
    let(:ingredient) { described_class.new(taxon: taxon) }

    it_behaves_like "an alchemy ingredient"

    describe "#taxon" do
      subject { ingredient.taxon }

      it "returns the taxon" do
        is_expected.to eq(taxon)
      end

      context "without taxon" do
        let(:taxon) { nil }

        it { is_expected.to be_nil }
      end
    end

    describe "#preview_text" do
      subject { ingredient.preview_text(30) }

      it "returns the taxons name" do
        is_expected.to eq(taxon.name)
      end

      context "without taxon" do
        let(:taxon) { nil }

        it { is_expected.to be_nil }
      end
    end
  end
end
