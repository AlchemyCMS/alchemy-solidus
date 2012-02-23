authorization do
  
  role :admin do
    has_permission_on :spree_admin_orders, :to => [:index]
  end
  
end
