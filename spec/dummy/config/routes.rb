Rails.application.routes.draw do
  mount Spree::Core::Engine, at: "/"
  mount Alchemy::Engine, at: '/'
end
