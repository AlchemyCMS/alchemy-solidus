# Include this to make Alchemy render within the Solidus layout
Alchemy::BaseHelper.send :include, Spree::BaseHelper
Alchemy::BaseHelper.send :include, Spree::StoreHelper
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Common
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Store
