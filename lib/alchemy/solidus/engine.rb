require 'alchemy/solidus/alchemy_user_extension'
require 'alchemy/solidus/spree_user_extension'

module Alchemy
  module Solidus
    class Engine < ::Rails::Engine
      engine_name 'alchemy_solidus'

      initializer 'alchemy_solidus.assets' do |app|
        app.config.assets.precompile += [
          'alchemy/solidus/alchemy_module_icon.png'
        ]
      end

      config.to_prepare do
        Alchemy.register_ability ::Spree::Ability
        ::Spree::Ability.register_ability ::Alchemy::Permissions
        Spree::User.include Spree::AlchemyUserExtension if Alchemy.user_class_name == 'Spree::User'
        Alchemy::User.include Alchemy::SpreeUserExtension if Alchemy.user_class_name == 'Alchemy::User'
      end
    end
  end
end
