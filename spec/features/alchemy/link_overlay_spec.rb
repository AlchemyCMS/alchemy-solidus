# frozen_string_literal: true

require "rails_helper"
require "alchemy/devise/test_support/factories"

RSpec.describe "Link overlay" do
  let(:a_page) { create(:alchemy_page) }

  let(:element) do
    build(
      :alchemy_element,
      name: "article",
      page_version: a_page.draft_version,
      autogenerate_ingredients: true
    )
  end

  let!(:product) { create(:product) }

  before do
    admin_user =
      create(:alchemy_admin_user).tap do |user|
        user.generate_spree_api_key
        user.save!
      end
    authorize_user admin_user

    allow(element).to receive(:definition) do
      {
        name: "article",
        ingredients: [
          {role: "headline", type: "Text", settings: {linkable: true}}
        ]
      }
    end

    element.save!
  end

  it "should be possible to link a product", js: true do
    visit alchemy.edit_admin_page_path(a_page)

    within "#element_#{element.id}" do
      fill_in "Headline", with: "Link me"
      begin
        click_link Alchemy.t(:place_link)
      rescue Capybara::ElementNotFound
        click_button_with_tooltip Alchemy.t(:place_link)
      end
    end

    within "#overlay_tabs" do
      find("sl-tab", text: "Product").click
    rescue Capybara::ElementNotFound
      click_link "Product"
    end

    within "[name=overlay_tab_product_link]" do
      expect(page).to have_selector("#s2id_product_link")
      select2_search(product.name, from: "Product")
      click_button "apply"
    end

    within "#element_#{element.id}" do
      click_button "Save"
    end

    within "#flash_notices" do
      expect(page).to have_content "Saved element."
    end

    expect(page).to have_css("iframe#alchemy_preview_window", wait: 5)
    within_frame "alchemy_preview_window" do
      expect(page).to have_link("Link me", href: "/products/#{product.slug}")
    end
  end
end
