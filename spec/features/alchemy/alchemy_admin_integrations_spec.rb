require "alchemy/version"
require "rails_helper"

RSpec.feature "Admin Integration", type: :feature do
  let!(:user) do
    create(:alchemy_admin_user, spree_roles: [::Spree::Role.create!(name: "admin")])
  end

  it "gets redirected to login if accessing admin" do
    visit "/admin"

    expect(page).to have_field "user_login"
  end

  it "it is possible to login and visit Alchemy admin" do
    login!
    visit "/admin/dashboard"

    expect(page).to have_content "Welcome back"
  end

  it "it is possible to login and visit Solidus admin" do
    login!
    visit "/admin/orders"

    expect(page).to have_content "No Orders found"
  end

  it "it disables turbolinks on Solidus link" do
    login!
    visit "/admin/pages"

    expect(page).to have_css ".main_navi_entry[data-turbolinks='false']"
  end

  it "it disables turbo on Solidus link" do
    login!
    visit "/admin/pages"

    expect(page).to have_css ".main_navi_entry[data-turbo='false']"
  end

  private

  def login!
    visit "/admin/login"

    expect(page).to have_field "user_login"
    fill_in "user_login", with: user.login
    fill_in "user_password", with: user.password

    click_button "Login"
  end
end
