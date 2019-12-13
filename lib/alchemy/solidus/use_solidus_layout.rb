# Make sure we have everything loaded before patching classes
Rails.application.config.to_prepare do
  # Allows to use Solidus helpers within Alchemys controller views
  Alchemy::BaseHelper.include Spree::BaseHelper
  Alchemy::BaseHelper.include Spree::CheckoutHelper
  Alchemy::BaseHelper.include Spree::ProductsHelper
  Alchemy::BaseHelper.include Spree::StoreHelper
  Alchemy::BaseHelper.include Spree::TaxonsHelper

  Alchemy::BaseController.include Spree::Core::ControllerHelpers::Auth
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::Common
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::Order
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::PaymentParameters
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::Pricing
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::Search
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::Store
  Alchemy::BaseController.include Spree::Core::ControllerHelpers::StrongParameters
end
