# Include this to make Alchemy render within the Solidus layout
Alchemy::BaseHelper.send :include, Spree::BaseHelper
Alchemy::BaseHelper.send :include, Spree::StoreHelper
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Auth
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Common
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Order
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::PaymentParameters
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Pricing
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Search
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Store
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::StrongParameters
