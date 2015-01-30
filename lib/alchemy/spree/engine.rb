require 'alchemy/spree/ability'
require 'alchemy/spree/alchemy_language_store'
require 'spree'

module Alchemy
  module Spree
    class Engine < ::Rails::Engine
      engine_name 'alchemy_spree'

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/**/*_decorator*.rb")) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
        Alchemy.register_ability(Alchemy::Spree::Ability)
      end

      config.to_prepare &method(:activate).to_proc
    end
  end
end
