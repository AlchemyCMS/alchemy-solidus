# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spree::Product, type: :model do
  it { is_expected.to have_many(:alchemy_ingredients) }

  describe "cache invalidation" do
    let(:page) { create(:alchemy_page) }
    let(:page_version) { create(:alchemy_page_version, page: page) }
    let(:element) { create(:alchemy_element, page_version: page_version) }
    let!(:ingredient) { Alchemy::Ingredients::SpreeProduct.create!(element: element, role: "product", related_object: product) }
    let(:product) { create(:product) }

    it "invalidates the cache on update" do
      travel_to 5.minutes.from_now do
        current_time = Time.current
        expect { product.reload.update!(name: "New name") }.to change { ingredient.reload.updated_at }.to(current_time)
        expect(element.reload.updated_at).to eq(current_time)
        expect(page_version.reload.updated_at).to eq(current_time)
        expect(page.reload.updated_at).to eq(current_time)
      end
    end

    it "invalidates the cache on touch" do
      travel_to 5.minutes.from_now do
        current_time = Time.current
        expect { product.reload.touch }.to change { ingredient.reload.updated_at }.to(current_time)
        expect(element.reload.updated_at).to eq(current_time)
        expect(page_version.reload.updated_at).to eq(current_time)
        expect(page.reload.updated_at).to eq(current_time)
      end
    end
  end
end
