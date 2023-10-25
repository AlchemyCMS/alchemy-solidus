require "rails/generators"
require "alchemy/version"

if Alchemy.gem_version >= Gem::Version.new("5.0.0.a")
  require "generators/alchemy/install/install_generator"
else
  require "rails/generators/alchemy/install/install_generator"
end

require "generators/spree/custom_user/custom_user_generator"
require "solidus_support"

begin
  require "generators/alchemy/devise/install/install_generator"
rescue LoadError
end

module Alchemy
  module Solidus
    class InstallGenerator < Rails::Generators::Base
      SPREE_MOUNT_REGEXP = /mount\sSpree::Core::Engine.*$/
      desc "Installs Alchemy Solidus into your App."

      class_option :skip_alchemy_installer,
                   default: false,
                   type: :boolean,
                   desc:
                     "Set true if you don't want to run the Alchemy installer"
      class_option :skip_alchemy_devise_installer,
                   default: false,
                   type: :boolean,
                   desc:
                     "Set true if you don't want to run the Alchemy Devise installer. NOTE: Automatically skipped if Alchemy::Devise is not available."
      class_option :skip_spree_custom_user_generator,
                   default: false,
                   type: :boolean,
                   desc:
                     "Set true if you don't want to run the Solidus custom user generator. NOTE: Automatically skipped if Alchemy::Devise is not available."
      class_option :skip_alchemy_user_generator,
                   default: false,
                   type: :boolean,
                   desc:
                     "Set true if you don't want to generate an admin user. NOTE: Automatically skipped if Alchemy::Devise is not available."
      class_option :auto_accept,
                   default: false,
                   type: :boolean,
                   desc: "Set true if run from a automated script (ie. on a CI)"

      source_root File.expand_path("files", __dir__)

      def run_alchemy_installer
        unless options[:skip_alchemy_installer]
          arguments =
            (
              if options[:auto_accept]
                %w[--skip-demo-files --skip --auto-accept]
              else
                []
              end
            )
          Alchemy::Generators::InstallGenerator.start(arguments)
          rake("railties:install:migrations", abort_on_failure: true)
          rake("db:migrate", abort_on_failure: true)
        end
      end

      def run_alchemy_devise_installer
        if alchemy_devise_present? && !options[:skip_alchemy_devise_installer]
          arguments = options[:auto_accept] ? ["--force"] : []
          Alchemy::Devise::Generators::InstallGenerator.start(arguments)
        end
      end

      def run_spree_custom_user_generator
        if alchemy_devise_present? &&
             !options[:skip_spree_custom_user_generator]
          arguments =
            (
              if options[:auto_accept]
                %w[Alchemy::User --force]
              else
                ["Alchemy::User"]
              end
            )
          Spree::CustomUserGenerator.start(arguments)
          gsub_file "lib/spree/authentication_helpers.rb",
                    /main_app\./,
                    "Alchemy."
          rake("db:migrate", abort_on_failure: true)
        end
      end

      def create_admin_user
        if alchemy_devise_present? && !options[:skip_alchemy_user_generator] &&
             Alchemy::User.count.zero?
          login = ENV.fetch("ALCHEMY_ADMIN_USER_LOGIN", "admin")
          email = ENV.fetch("ALCHEMY_ADMIN_USER_EMAIL", "admin@example.com")
          password = ENV.fetch("ALCHEMY_ADMIN_USER_PASSWORD", "test1234")
          unless options[:auto_accept]
            login =
              ask("\nEnter the username for the admin user", default: login)
            email = ask("Enter the email for the admin user", default: email)
            password =
              ask("Enter the password for the admin user", default: password)
          end

          # This is a bit strange, but without the double save this fails with a failed validation.
          Alchemy::User
            .create!(
              login: login,
              email: email,
              password: password,
              password_confirmation: password,
              alchemy_roles: "admin"
            )
            .tap do |user|
              user.spree_roles = [Spree::Role.find_or_create_by!(name: "admin")]
              user.save!
            end
        end
      end

      def inject_routes
        routes_file_path = Rails.root.join("config", "routes.rb")
        mountpoint = "/"
        unless options[:auto_accept]
          mountpoint =
            ask(
              "\nAt which path do you want to mount AlchemyCMS at?",
              default: mountpoint
            )
        end
        if File.read(routes_file_path).match SPREE_MOUNT_REGEXP
          sentinel = SPREE_MOUNT_REGEXP
        else
          sentinel = "Rails.application.routes.draw do\n"
        end
        inject_into_file routes_file_path, { after: sentinel } do
          "\n  mount Alchemy::Engine, at: '/#{mountpoint.chomp("/")}'\n"
        end
      end

      def set_root_route
        routes_file_path = Rails.root.join("config", "routes.rb")
        if options[:auto_accept] ||
             yes?("\nDo you want Alchemy to handle the root route '/'? (y/n)")
          sentinel = "Rails.application.routes.draw do\n"
          inject_into_file routes_file_path, { after: sentinel } do
            <<~ROOT_ROUTE
              \  # Let AlchemyCMS handle the root route
              \  root to: 'alchemy/pages#index'
            ROOT_ROUTE
          end
          copy_file("db/seeds/alchemy/pages.yml")
          rake("alchemy:db:seed", abort_on_failure: true)
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
