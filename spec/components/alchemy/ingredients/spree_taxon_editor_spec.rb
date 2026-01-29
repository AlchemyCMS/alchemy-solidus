# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Ingredients::SpreeTaxonEditor, type: :component do
  let(:element) { build_stubbed(:alchemy_element, name: "all_you_can_eat") }
  let(:ingredient_editor) { described_class.new(ingredient) }
  let(:ingredient) { Alchemy::Ingredients::SpreeTaxon.new(id: 1234, element: element, role: "taxon") }

  before do
    allow(element).to receive(:definition) do
      Alchemy::ElementDefinition.new(
        name: "all_you_can_eat",
        ingredients: [
          {role: "taxon",
           type: "SpreeTaxon"}
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

  it "renders a taxon input" do
    is_expected.to have_css("alchemy-taxon-select input.full_width")
  end

  context "with a taxon related to ingredient" do
    let(:taxon) { Spree::Taxon.new(id: 1) }

    let(:ingredient) do
      Alchemy::Ingredients::SpreeTaxon.new(element: element, role: "taxon", taxon: taxon)
    end

    it "sets taxon id as value" do
      is_expected.to have_css('alchemy-taxon-select[selection] input[value="1"]')
    end
  end
end
