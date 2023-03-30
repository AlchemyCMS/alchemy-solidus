require "alchemy/version"
require "rails_helper"
require "alchemy/devise/test_support/factories"

RSpec.feature "Admin Integration", type: :feature do
  let!(:user) { create(:alchemy_admin_user) }

  it "gets redirected to login if accessing admin" do
    visit "/admin"

    expect(page).to have_field "user_login"
  end

  it "it is possible to login and visit Alchemy admin" do
    login!
    visit "/admin/dashboard"

    expect(page).to have_content "Welcome back"
  end

  it "it is possible to login and visit Spree admin" do
    login!
    visit "/admin/orders"

    expect(page).to have_content "No Orders found"
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
