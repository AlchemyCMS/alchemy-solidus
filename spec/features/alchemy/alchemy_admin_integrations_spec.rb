require 'rails_helper'
begin
  require 'factory_girl'
rescue LoadError
end
require 'spree/testing_support/factories/address_factory'

RSpec.feature "Admin Integration", type: :feature do
  let!(:admin) do
    Alchemy::User.create!(
      login: 'admin',
      password: 'S3cre#t',
      password_confirmation: 'S3cre#t',
      email: 'email@example.com',
      alchemy_roles: 'admin',
      spree_roles: [Spree::Role.first_or_create!(name: 'admin')],
      bill_address: FactoryBot.create(:address)
    )
  end

  it 'it is possible to login and visit Alchemy admin' do
    login!
    visit '/admin/dashboard'

    expect(page).to have_content 'Welcome back'
  end

  it 'it is possible to login and visit Spree admin' do
    login!
    visit '/admin/orders'

    expect(page).to have_content 'No Orders found'
  end

  private

  def login!
    visit '/admin/login'

    expect(page).to have_field 'user_login'
    fill_in 'user_login', with: admin.login
    fill_in 'user_password', with: admin.password
    click_button 'login'
  end
end
