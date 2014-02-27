Alchemy::Engine.routes.draw do
  get '/admin/spree' => 'admin/spree#index', :as => :spree_admin
end
