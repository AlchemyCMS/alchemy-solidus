# frozen_string_literal: true

require 'rails_helper'
require 'alchemy/test_support/essence_shared_examples'
require 'alchemy/test_support/factories/page_factory'
require 'alchemy/test_support/factories/element_factory'
require 'alchemy/test_support/factories/content_factory'

require_dependency 'alchemy/site'

RSpec.describe Alchemy::EssenceSpreeTaxon, type: :model do
  let(:taxon) { build_stubbed(:taxon) }
  let(:essence) { described_class.new(taxon: taxon) }

  it_behaves_like 'an essence' do
    let(:ingredient_value) { taxon }
  end

  describe 'ingredient=' do
    context 'when String value is only a number' do
      let(:value) { '101' }

      before do
        essence.ingredient = value
      end

      it 'sets taxon_id with that id' do
        expect(essence.taxon_id).to eq(101)
      end
    end

    context 'when value is an Spree Variant' do
      let(:value) { taxon }

      before do
        essence.ingredient = value
      end

      it 'sets taxon to that taxon' do
        expect(essence.taxon).to eq(taxon)
      end
    end

    context 'when value is not only a number' do
      let(:value) { 'taxon1' }

      it do
        expect {
          essence.ingredient = value
        }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
    end
  end

  describe '#preview_text' do
    subject { essence.preview_text(nil) }

    it 'returns the taxons name' do
      is_expected.to eq(taxon.name)
    end
  end
end
