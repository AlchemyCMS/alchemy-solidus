Alchemy::Engine.routes.prepend do
  get '/admin/spree' => 'admin/spree#index', :as => :spree_admin
end
