require "alchemy_spree/alchemy_module"
require 'alchemy_spree/alchemy_language_id_store'

module AlchemySpree
  class Engine < ::Rails::Engine
    engine_name 'alchemy_spree'

    initializer 'spree.user_class' do
      Spree.user_class = "Alchemy::User"
      require File.join(File.dirname(__FILE__), '../spree/authentication_helpers')
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
