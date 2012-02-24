require 'deface'

Deface::Override.new(
	:virtual_path => "spree/layouts/admin",
	:name => "alchemy_cms",
	:insert_bottom => "[data-hook='admin_tabs']",
	:text => "<li><%= link_to 'Alchemy CMS', alchemy.admin_dashboard_path %></li>"
)
