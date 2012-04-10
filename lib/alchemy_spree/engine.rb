require "alchemy_spree/alchemy_module"

module AlchemySpree
	class Engine < ::Rails::Engine
		engine_name 'alchemy_spree'

		config.autoload_paths += %W(#{config.root}/lib)

		def self.activate
			Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/**/*.rb")) do |c|
				Rails.application.config.cache_classes ? require(c) : load(c)
			end
		end

		config.to_prepare &method(:activate).to_proc
	end
end
