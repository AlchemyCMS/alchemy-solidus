# frozen_string_literal: true

require "rails_helper"

RSpec.describe "alchemy/ingredients/_spree_variant_editor" do
  let(:element) { build_stubbed(:alchemy_element, name: "all_you_can_eat") }
  let(:element_editor) { Alchemy::ElementEditor.new(element) }
  let(:ingredient) { Alchemy::Ingredients::SpreeVariant.new(element: element, role: "variant") }

  before do
    allow(element).to receive(:definition) do
      Alchemy::ElementDefinition.new(
        name: "all_you_can_eat",
        ingredients: [
          {role: "product",
           type: "SpreeProduct"},
          {role: "variant",
           type: "SpreeVariant"},
          {role: "taxon",
           type: "SpreeTaxon"}
        ]
      )
    end

    allow(element_editor).to receive(:ingredients) { [Alchemy::IngredientEditor.new(ingredient)] }
    view.class.send(:include, Alchemy::Admin::IngredientsHelper)
    view.class.define_method(:current_alchemy_user) { nil } # trick rspec-mocks to allow this method to be stubbed
    allow(view).to receive(:current_alchemy_user) { build_stubbed(:alchemy_admin_user) }
  end

  subject do
    render element_editor
    rendered
  end

  it_behaves_like "an alchemy ingredient editor"

  it "renders a variant input" do
    is_expected.to have_css("alchemy-variant-select input.full_width")
  end

  context "with a variant related to ingredient" do
    let(:variant) { Spree::Variant.new(id: 1, product: Spree::Product.new) }

    let(:ingredient) do
      Alchemy::Ingredients::SpreeVariant.new(element: element, role: "variant", variant: variant)
    end

    it "sets variant id as value" do
      is_expected.to have_css('alchemy-variant-select input[value="1"]')
    end
  end
end
