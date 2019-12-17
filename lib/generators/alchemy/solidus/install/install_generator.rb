require 'rails/generators'
require 'rails/generators/alchemy/install/install_generator'
require 'generators/spree/custom_user/custom_user_generator'
require 'solidus_support'

begin
  require 'generators/alchemy/devise/install/install_generator'
rescue LoadError
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
      class_option :skip_alchemy_user_generator, default: false, type: :boolean,
        desc: "Set true if you don't want to generate an admin user. NOTE: Automatically skipped if Alchemy::Devise is not available."
      class_option :auto_accept, default: false, type: :boolean,
        desc: 'Set true if run from a automated script (ie. on a CI)'

      source_root File.expand_path('templates', __dir__)

      def run_alchemy_installer
        unless options[:skip_alchemy_installer]
          arguments = options[:auto_accept] ? ['--skip-demo-files', '--force'] : []
          Alchemy::Generators::InstallGenerator.start(arguments)
          rake('railties:install:migrations', abort_on_failure: true)
          rake('db:migrate', abort_on_failure: true)
        end
      end

      def run_alchemy_devise_installer
        if alchemy_devise_present? && !options[:skip_alchemy_devise_installer]
          arguments = options[:auto_accept] ? ['--force'] : []
          Alchemy::Devise::Generators::InstallGenerator.start(arguments)
        end
      end

      def run_spree_custom_user_generator
        if alchemy_devise_present? && !options[:skip_spree_custom_user_generator]
          arguments = options[:auto_accept] ? ['Alchemy::User', '--force'] : ['Alchemy::User']
          Spree::CustomUserGenerator.start(arguments)
          gsub_file 'lib/spree/authentication_helpers.rb', /main_app\./, 'Alchemy.'
          if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.0')
            gsub_file 'config/initializers/spree.rb', /Spree\.user_class.?=.?.+$/, 'Spree.user_class = "Alchemy::User"'
          end
          rake('db:migrate', abort_on_failure: true)
        end
      end

      def copy_alchemy_initializer
        template "alchemy.rb.tt", "config/initializers/alchemy.rb"
      end

      def inject_admin_tab
        inject_into_file 'config/initializers/spree.rb', {after: "Spree::Backend::Config.configure do |config|\n"} do
          <<~ADMIN_TAB
            \  # AlchemyCMS admin tabs
            \  config.menu_items << config.class::MenuItem.new(
            \    [:pages, :sites, :languages, :tags, :users, :pictures, :attachments],
            \    'copy',
            \    label: :cms,
            \    condition: -> { can?(:index, :alchemy_admin_dashboard) },
            \    partial: 'spree/admin/shared/alchemy_sub_menu',
            \    url: '/admin/pages',
            \    match_path: '/pages'
            \  )
          ADMIN_TAB
        end
      end

      def create_admin_user
        if alchemy_devise_present? && !options[:skip_alchemy_user_generator] && Alchemy::User.count.zero?
          login = ENV.fetch('ALCHEMY_ADMIN_USER_LOGIN', 'admin')
          email = ENV.fetch('ALCHEMY_ADMIN_USER_EMAIL', 'admin@example.com')
          password = ENV.fetch('ALCHEMY_ADMIN_USER_PASSWORD', 'test1234')
          unless options[:auto_accept]
            login = ask("\nEnter the username for the admin user", default: login)
            email = ask("Enter the email for the admin user", default: email)
            password = ask("Enter the password for the admin user", default: password)
          end

          Alchemy::User.create!(
            login: login,
            email: email,
            password: password,
            password_confirmation: password,
            alchemy_roles: 'admin',
            spree_roles: [Spree::Role.find_or_create_by!(name: 'admin')]
          )
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

      def set_root_route
        routes_file_path = Rails.root.join('config', 'routes.rb')
        if options[:auto_accept] || ask("\nDo you want Alchemy to handle the root route ('/')?", default: true)
          if File.read(routes_file_path).match SPREE_MOUNT_REGEXP
            sentinel = SPREE_MOUNT_REGEXP
          else
            sentinel = "Rails.application.routes.draw do\n"
          end
          inject_into_file routes_file_path, {after: sentinel} do
            <<~ROOT_ROUTE
              \n
              \  # Let AlchemyCMS handle the root route
              \  Spree::Core::Engine.routes.draw do
              \    root to: '/alchemy/pages#index'
              \  end
            ROOT_ROUTE
          end
        end
      end

      def append_assets
        append_file "vendor/assets/javascripts/alchemy/admin/all.js",
          "//= require alchemy/solidus/admin.js"
      end

      private

      def alchemy_devise_present?
        defined?(Alchemy::Devise::Engine)
      end
    end
  end
end
