AlchemySpree::Engine.routes.draw do
	match 'admin/spree' => 'alchemy/admin/spree#index', :as => :spree_admin
end