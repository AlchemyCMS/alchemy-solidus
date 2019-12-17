require 'alchemy_cms'
require 'solidus_core'
require 'solidus_backend'
require 'solidus_support'

module Alchemy
  module Solidus
    class Engine < ::Rails::Engine
      engine_name 'alchemy_solidus'

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
          require 'alchemy/solidus/spree_admin_unauthorized_redirect'
        end

        if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5')
          require 'alchemy/solidus/spree_custom_user_generator_fix'
          require 'alchemy/solidus/spree_install_generator_fix'
        end

        if SolidusSupport.frontend_available?
          # Allows to render Alchemy content within Solidus' controller views
          require_dependency 'alchemy/solidus/alchemy_in_solidus'
        end

        # Allows to use Solidus helpers within Alchemys controller views
        require_dependency 'alchemy/solidus/use_solidus_layout'
      end

      # Fix for +belongs_to :bill_address+ in {Spree::UserAddressBook}
      # Solidus has this set to +false+ in {Spree::Base}, but {Alchemy::User} does not inherit from it.
      initializer 'alchemy_solidus.belongs_bill_address_fix' do
        if Alchemy.user_class_name == 'Alchemy::User'
          ActiveSupport.on_load(:active_record) do
            Alchemy::User.belongs_to_required_by_default = false
          end
        end
      end

      # In versions of Solidus prior to 2.8, we override the tabs partial
      # to pass a match_path value to each tab. (Version 2.8 is already
      # passing this option.) This option is used to configure the paths
      # for which a given tab is active.
      #
      if Spree.solidus_gem_version < Gem::Version.new('2.8')
        paths['app/views'] << 'lib/views'
      end
    end
  end
end
