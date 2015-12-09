require 'alchemy/solidus/ability'
require 'solidus'
require_relative '../../../config/routes'

module Alchemy
  module Solidus
    class Engine < ::Rails::Engine
      engine_name 'alchemy_solidus'

      def self.activate
        Alchemy.register_ability(::Alchemy::Solidus::Ability)
        Alchemy.register_ability(::Spree::Ability)
      end

      config.to_prepare &method(:activate).to_proc
    end
  end
end
