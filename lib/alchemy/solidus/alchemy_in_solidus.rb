# Allow Alchemy content within Solidus views
Spree::BaseController.send :include, Alchemy::ControllerActions
Spree::UserSessionsController.send :include, Alchemy::ControllerActions if defined? Spree::UserSessionsController
Spree::BaseController.send :include, Alchemy::ConfigurationMethods
