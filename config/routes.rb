Alchemy::Engine.routes.draw do
  get '/admin/solidus' => 'admin/solidus#index', :as => :solidus_admin
end
