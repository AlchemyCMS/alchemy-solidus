require 'rails/generators'
require 'rails/generators/alchemy/install/install_generator'
require 'generators/spree/custom_user/custom_user_generator'

begin
  require 'generators/alchemy/devise/install/install_generator'
rescue
end

module Alchemy
  module Solidus
    class InstallGenerator < Rails::Generators::Base
      SPREE_MOUNT_REGEXP = /mount\sSpree::Core::Engine.*$/
      desc "Installs Alchemy Solidus into your App."

      class_option :skip_alchemy_installer, default: false, type: :boolean,
        desc: "Set true if you don't want to run the Alchemy installer"
      class_option :skip_alchemy_devise_installer, default: false, type: :boolean,
        desc: "Set true if you don't want to run the Alchemy Devise installer. NOTE: Automatically skipped if Alchemy::Devise is not available."
      class_option :skip_spree_custom_user_generator, default: false, type: :boolean,
        desc: "Set true if you don't want to run the Solidus custom user generator. NOTE: Automatically skipped if Alchemy::Devise is not available."
      class_option :auto_accept, default: false, type: :boolean,
        desc: 'Set true if run from a automated script (ie. on a CI)'

      def run_alchemy_installer
        unless options[:skip_alchemy_installer]
          arguments = options[:auto_accept] ? ['--skip-demo-files', '--force'] : []
          Alchemy::Generators::InstallGenerator.start(arguments)
        end
      end

      def run_alchemy_devise_installer
        if Kernel.const_defined?('Alchemy::Devise') && !options[:skip_alchemy_devise_installer]
          arguments = options[:auto_accept] ? ['--force'] : []
          Alchemy::Devise::Generators::InstallGenerator.start(arguments)
        end
      end

      def run_spree_custom_user_generator
        if Kernel.const_defined?('Alchemy::Devise') && !options[:skip_spree_custom_user_generator]
          arguments = options[:auto_accept] ? ['Alchemy::User', '--force'] : ['Alchemy::User']
          Spree::CustomUserGenerator.start(arguments)
          spree_initializer_file = Rails.root.join('config', 'initializers', 'spree.rb')
          file_action = File.exist?(spree_initializer_file) ? :append_file : :create_file
          public_send(file_action, spree_initializer_file) do
            %{\nSpree.user_class = "Alchemy::User"\n}
          end
          rake 'db:migrate'
        end
      end

      def inject_routes
        routes_file_path = Rails.root.join('config', 'routes.rb')
        mountpoint = '/'
        unless options[:auto_accept]
          mountpoint = ask("\nAt which path do you want to mount AlchemyCMS at?", default: mountpoint)
        end
        if File.read(routes_file_path).match SPREE_MOUNT_REGEXP
          sentinel = SPREE_MOUNT_REGEXP
        else
          sentinel = "Rails.application.routes.draw do\n"
        end
        inject_into_file routes_file_path, {after: sentinel} do
          "\n  mount Alchemy::Engine, at: '/#{mountpoint.chomp('/')}'\n"
        end
      end
    end
  end
end
