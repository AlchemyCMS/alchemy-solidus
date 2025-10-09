require "alchemy/solidus/configuration"

module Alchemy
  module Solidus
    extend self

    def config
      @_config ||= Alchemy::Solidus::Configuration.new
    end
  end
end

require "alchemy/solidus/engine"
