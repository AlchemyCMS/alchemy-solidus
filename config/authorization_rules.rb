authorization do
  role :admin do
    has_permission_on :alchemy_admin_spree, :to => [:index]
  end
end
