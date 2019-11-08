# frozen_string_literal: true

require 'rails_helper'
require 'alchemy/test_support/essence_shared_examples'
require 'alchemy/test_support/factories/page_factory'
require 'alchemy/test_support/factories/element_factory'
require 'alchemy/test_support/factories/content_factory'
require 'spree/testing_support/factories/variant_factory'

require_dependency 'alchemy/site'

RSpec.describe Alchemy::EssenceSpreeVariant, type: :model do
  let(:variant) { build(:variant) }
  let(:essence) { described_class.new(variant: variant) }

  it_behaves_like 'an essence' do
    let(:ingredient_value) { variant }
  end

  describe 'ingredient=' do
    context 'when String value is only a number' do
      let(:value) { '101' }

      before do
        essence.ingredient = value
      end

      it 'sets variant_id with that id' do
        expect(essence.variant_id).to eq(101)
      end
    end

    context 'when value is an Spree Variant' do
      let(:value) { variant }

      before do
        essence.ingredient = value
      end

      it 'sets variant to that variant' do
        expect(essence.variant).to eq(variant)
      end
    end

    context 'when value is not only a number' do
      let(:value) { 'variant1' }

      it do
        expect {
          essence.ingredient = value
        }.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
    end
  end
end
