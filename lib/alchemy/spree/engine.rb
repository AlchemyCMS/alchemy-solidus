require 'alchemy/spree/ability'
require 'spree'

module Alchemy
  module Spree
    class Engine < ::Rails::Engine
      engine_name 'alchemy_spree'

      def self.activate
        Alchemy.register_ability(::Alchemy::Spree::Ability)
        Alchemy.register_ability(::Spree::Ability)
      end

      config.to_prepare &method(:activate).to_proc
    end
  end
end
