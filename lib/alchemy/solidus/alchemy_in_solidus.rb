##
# If there is the Devise Constant loaded, we can assume that we use it as the authentication method
# then we set the ParentController of device as the Spree::BaseController
# https://github.com/AlchemyCMS/alchemy-solidus/issues/10
if Object.const_defined?("Devise")
  Devise.setup do |config|
    config.parent_controller = "Spree::BaseController"
  end
end

# Allow Alchemy content within Solidus views
Spree::BaseController.send :include, Alchemy::ControllerActions
Spree::UserSessionsController.send :include, Alchemy::ControllerActions if defined? Spree::UserSessionsController
Spree::BaseController.send :include, Alchemy::ConfigurationMethods
