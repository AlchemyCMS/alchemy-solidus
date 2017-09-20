Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :products do
      resource :page, only: [:edit]
    end
  end
end
