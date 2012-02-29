Dummy::Application.routes.draw do
  mount Alchemy::Engine => '/'
  mount Spree::Core::Engine => '/shop'
end
