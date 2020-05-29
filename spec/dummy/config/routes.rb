Rails.application.routes.draw do
  # Let AlchemyCMS handle the root route
  root to: 'alchemy/pages#index'

  mount Spree::Core::Engine, at: "/"
  mount Alchemy::Engine, at: '/'
end
