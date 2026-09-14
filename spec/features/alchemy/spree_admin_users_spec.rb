require "rails_helper"
require "spree/testing_support/authorization_helpers"
require "spree/testing_support/capybara_ext"

RSpec.describe "Spree Admin Users", type: :feature do
  stub_authorization!

  describe "editing a user" do
    let(:user) { create(:alchemy_user) }

    it "shows the alchemy roles field", :js do
      visit spree.edit_admin_user_path(user)

      select2_search "Editor", from: "Alchemy Roles"
      # For some weird reason the factory does not create a valid user
      # or devise wants us to re-enter the password when updating the user.
      # It does not matter, just fill in the password fields.
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
      click_button "Update"
      expect(page).to have_content("Account updated")
      expect(user.reload.alchemy_roles).to include("editor")
    end
  end
end
