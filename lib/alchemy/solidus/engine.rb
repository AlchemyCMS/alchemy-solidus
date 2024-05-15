require "alchemy_cms"
require "alchemy/version"
require "solidus_core"
require "solidus_backend"
require "solidus_support"

module Alchemy
  module Solidus
    class Engine < ::Rails::Engine
      include SolidusSupport::EngineExtensions
      engine_name "alchemy_solidus"

      config.to_prepare do
        Alchemy.register_ability ::Spree::Ability
        ::Spree::Ability.register_ability ::Alchemy::Permissions

        if Alchemy.user_class_name == "::Spree::User"
          require "alchemy/solidus/spree_user_extension"
          Spree::User.include Alchemy::Solidus::SpreeUserExtension
        end

        if Alchemy.user_class_name == "::Alchemy::User"
          require "alchemy/solidus/alchemy_user_extension"
          require "alchemy/solidus/current_user_helpers"
          Alchemy::User.include Alchemy::Solidus::AlchemyUserExtension
          ApplicationController.include Alchemy::Solidus::CurrentUserHelpers
          require "alchemy/solidus/spree_admin_unauthorized_redirect"
        end

        if SolidusSupport.frontend_available?
          # Allows to render Alchemy content within Solidus' controller views
          require_dependency "alchemy/solidus/alchemy_in_solidus"
        end

        # Allows to use Solidus helpers within Alchemys controller views
        require_dependency "alchemy/solidus/use_solidus_layout"
      end
    end
  end
end
