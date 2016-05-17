module Alchemy
  module Solidus
    class Engine < ::Rails::Engine
      engine_name 'alchemy_solidus'

      initializer 'alchemy_solidus.assets' do |app|
        app.config.assets.precompile += [
          'alchemy/solidus/alchemy_module_icon.png'
        ]
      end

      def self.activate
        Alchemy.register_ability(::Spree::Ability)
      end

      config.to_prepare &method(:activate).to_proc
    end
  end
end
