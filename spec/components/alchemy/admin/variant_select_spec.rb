# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Admin::VariantSelect, type: :component do
  let(:api_key) { "123" }
  let(:url) { Spree::Core::Engine.routes.url_helpers.api_variants_path }
  let(:variant) { nil }
  let(:query_params) { nil }

  before do
    render_inline(described_class.new(
      api_key,
      url: url,
      variant: variant,
      query_params: query_params
    ))
  end

  it "has a variant select" do
    expect(page).to have_selector(
      "alchemy-variant-select[api-key='#{api_key}'][url='#{url}']"
    )
  end

  context "with a variant" do
    let(:variant) { create(:variant) }

    it "adds a selection" do
      expect(page).to have_selector("alchemy-variant-select[selection]")
    end
  end

  context "with query-params" do
    let(:query_params) { {available: true} }

    it "adds a selection" do
      expect(page).to have_selector(
        "alchemy-variant-select[query-params='{\"available\":true}']"
      )
    end
  end
end
