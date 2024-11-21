# Hook into SolidusAuthDevise controllers if present
if defined? Spree::Auth::Engine
  Spree::UserPasswordsController.include Alchemy::ControllerActions
  Spree::UserConfirmationsController.include Alchemy::ControllerActions
  Spree::UserRegistrationsController.include Alchemy::ControllerActions
  Spree::UserSessionsController.include Alchemy::ControllerActions
end

# Do not prefix element view partials with `spree` namespace.
# See https://github.com/AlchemyCMS/alchemy_cms/issues/1626
ActionView::Base.prefix_partial_path_with_controller_namespace = false
