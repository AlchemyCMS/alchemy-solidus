# frozen_string_literal: true

require "rails_helper"
require "alchemy/test_support/relatable_resource_examples"

RSpec.describe Spree::Taxon, type: :model do
  it { is_expected.to have_many(:alchemy_ingredients) }

  it_behaves_like "a relatable resource",
    resource_factory_name: "taxon",
    ingredient_factory_name: "alchemy_ingredient_spree_taxon"
end
