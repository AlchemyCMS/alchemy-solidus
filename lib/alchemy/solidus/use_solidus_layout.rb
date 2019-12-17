# Allows to use Solidus helpers within Alchemys controller views
Alchemy::BaseHelper.include(
  Spree::BaseHelper,
  Spree::CheckoutHelper,
  Spree::ProductsHelper,
  Spree::StoreHelper,
  Spree::TaxonsHelper
)

Alchemy::BaseController.include(
  Spree::Core::ControllerHelpers::Auth,
  Spree::Core::ControllerHelpers::Common,
  Spree::Core::ControllerHelpers::Order,
  Spree::Core::ControllerHelpers::PaymentParameters,
  Spree::Core::ControllerHelpers::Pricing,
  Spree::Core::ControllerHelpers::Search,
  Spree::Core::ControllerHelpers::Store,
  Spree::Core::ControllerHelpers::StrongParameters
)
