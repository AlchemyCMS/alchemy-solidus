# -*- encoding: utf-8 -*-

require "alchemy_cms"

Alchemy::Modules.register_module({
	:name => 'spree',
	:engine_name => 'alchemy_spree',
	:navigation => {
		:controller => 'alchemy/admin/spree',
		:action => 'index',
		:name => 'Shop',
		:image => '/assets/alchemy_spree/alchemy_module_icon.png'
	}
})

Alchemy::AuthEngine.get_instance.load(File.join(File.dirname(__FILE__), '../..', 'config/authorization_rules.rb'))
