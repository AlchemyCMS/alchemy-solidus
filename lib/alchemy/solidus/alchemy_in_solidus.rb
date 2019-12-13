# Make sure we have everything loaded before patching classes
Rails.application.config.to_prepare do
  # Allows to render Alchemy content within Solidus' controller views
  Spree::BaseController.include Alchemy::ControllerActions
  Spree::BaseController.include Alchemy::ConfigurationMethods

  # Hook into SolidusAuthDevise controllers if present
  if defined? Spree::Auth::Engine
    Spree::UserPasswordsController.include Alchemy::ControllerActions
    Spree::UserConfirmationsController.include Alchemy::ControllerActions
    Spree::UserRegistrationsController.include Alchemy::ControllerActions
    Spree::UserSessionsController.include Alchemy::ControllerActions
  end
end
