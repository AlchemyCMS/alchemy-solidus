require 'alchemy/solidus/alchemy_user_extension'
require 'alchemy/solidus/spree_user_extension'
require 'alchemy_cms'
require 'solidus_core'
require 'solidus_backend'
require 'solidus_support'

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

        if Alchemy.user_class_name == 'Spree::User'
          require 'alchemy/solidus/spree_user_extension'
          Spree::User.include Alchemy::Solidus::SpreeUserExtension
        end

        if Alchemy.user_class_name == 'Alchemy::User'
          require 'alchemy/solidus/alchemy_user_extension'
          Alchemy::User.include Alchemy::Solidus::AlchemyUserExtension
        end

        if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5')
          require 'alchemy/solidus/spree_custom_user_generator_fix'
        end
      end
    end
  end
end
