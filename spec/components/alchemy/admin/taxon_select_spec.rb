# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Admin::TaxonSelect, type: :component do
  let(:api_key) { "123" }
  let(:url) { Spree::Core::Engine.routes.url_helpers.api_taxons_path }
  let(:taxon) { nil }
  let(:query_params) { nil }

  before do
    render_inline(described_class.new(
      api_key,
      url: url,
      taxon: taxon,
      query_params: query_params
    ))
  end

  it "has a taxon select" do
    expect(page).to have_selector(
      "alchemy-taxon-select[api-key='#{api_key}'][url='#{url}']"
    )
  end

  context "with a taxon" do
    let(:taxonomy) { create(:taxonomy, name: "Category") }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, name: "Taxon Name") }

    it "adds a selection" do
      expect(page).to have_selector("alchemy-taxon-select[selection]")
    end
  end

  context "with query-params" do
    let(:query_params) { {available: true} }

    it "adds a selection" do
      expect(page).to have_selector(
        "alchemy-taxon-select[query-params='{\"available\":true}']"
      )
    end
  end
end
