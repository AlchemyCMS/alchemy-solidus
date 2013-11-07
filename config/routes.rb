Alchemy::Engine.routes.append do
	get 'admin/spree' => 'alchemy/admin/spree#index', :as => :spree_admin
end
