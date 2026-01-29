# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Ingredients::SpreeVariantEditor, type: :component do
  let(:element) { build_stubbed(:alchemy_element, name: "all_you_can_eat") }
  let(:ingredient_editor) { described_class.new(ingredient) }
  let(:ingredient) { Alchemy::Ingredients::SpreeVariant.new(id: 1234, element: element, role: "variant") }

  before do
    allow(element).to receive(:definition) do
      Alchemy::ElementDefinition.new(
        name: "all_you_can_eat",
        ingredients: [
          {role: "variant",
           type: "SpreeVariant"}
        ]
      )
    end
    vc_test_view_context.class.include Alchemy::Admin::BaseHelper
    vc_test_view_context.class.define_method(:current_alchemy_user) { nil } # trick rspec-mocks to allow this method to be stubbed
    allow(vc_test_view_context).to receive(:current_alchemy_user) { build_stubbed(:alchemy_admin_user) }
  end

  subject do
    render_inline ingredient_editor
    page
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
      is_expected.to have_css('alchemy-variant-select[selection] input[value="1"]')
    end
  end
end
