# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spree::Taxon, type: :model do
  it { is_expected.to have_many(:alchemy_ingredients) }

  describe "cache invalidation" do
    let(:page) { create(:alchemy_page) }
    let(:page_version) { create(:alchemy_page_version, page: page) }
    let(:element) { create(:alchemy_element, page_version: page_version) }
    let!(:ingredient) { Alchemy::Ingredients::SpreeTaxon.create!(element: element, role: "taxon", related_object: taxon) }
    let(:taxon) { create(:taxon) }

    it "invalidates the cache on update" do
      expect {
        taxon.update!(name: "New name")
      }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeTaxon", taxon.id)
    end

    it "invalidates the cache on touch" do
      expect {
        taxon.touch
      }.to enqueue_job(Alchemy::Solidus::InvalidateElementsCacheJob).with("SpreeTaxon", taxon.id)
    end
  end
end
