require "alchemy_cms"
require "alchemy/version"
require "solidus_api"
require "solidus_core"
require "solidus_backend"
require "solidus_support"

begin
  require "solidus_frontend"
rescue LoadError
  # Solidus frontend is not available, but we can still load the engine
end

module Alchemy
  module Solidus
    class Engine < ::Rails::Engine
      include SolidusSupport::EngineExtensions
      engine_name "alchemy_solidus"

      initializer "alchemy_solidus.assets", before: "alchemy.importmap" do |app|
        Alchemy.config.admin_importmaps.add({
          importmap_path: root.join("config/importmap.rb"),
          source_paths: [
            root.join("app/javascript")
          ],
          name: engine_name
        })
        app.config.assets.precompile << "alchemy_solidus/manifest.js"
      end

      config.to_prepare do
        Alchemy.register_ability ::Spree::Ability
        ::Spree::Ability.register_ability ::Alchemy::Permissions

        if SolidusSupport.frontend_available?
          # Allows to render Alchemy content within Solidus' controller views

          # Do not prefix element view partials with `spree` namespace.
          # See https://github.com/AlchemyCMS/alchemy_cms/issues/1626
          ActionView::Base.prefix_partial_path_with_controller_namespace = false
        end
      end

      initializer "alchemy_solidus.patches" do |app|
        if Alchemy.gem_version < Gem::Version.new("7.4.0") && SolidusSupport.backend_available?
          app.config.to_prepare do
            Alchemy::Solidus::SpreeAdminBaseControllerPatch
          end
        end
      end
    end
  end
end
