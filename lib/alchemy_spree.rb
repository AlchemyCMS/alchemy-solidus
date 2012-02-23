require "alchemy_spree/version"
require 'deface'

Alchemy::Modules.register_module({
	:name => 'spree',
	:engine_name => 'spree',
	:image => '',
	:navigation => {
		:controller => 'spree/admin/orders',
		:action => 'index'
	}
})

Alchemy::AuthEngine.get_instance.load(File.join(File.dirname(__FILE__), '..', 'config/authorization_rules.rb'))

Deface::Override.new(
	:virtual_path => "spree/layouts/admin",
	:name => "alchemy_cms",
	:insert_bottom => "[data-hook='admin_tabs']",
	:text => "<li><%= link_to 'Alchemy CMS', alchemy.admin_dashboard_path %></li>"
)
