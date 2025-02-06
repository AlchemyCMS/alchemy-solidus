alchemy_module = {
  engine_name: 'spree',
  name: 'solidus',
  navigation: {
    controller: '/spree/admin/orders',
    action: 'index',
    name: 'Store',
    icon: Alchemy.gem_version >= Gem::Version.new("7.4.0.a") ? 'shopping-cart' : 'shopping-cart-line',
    data: { turbolinks: false },
    sub_navigation: [
      {
        controller: '/spree/admin/orders',
        action: 'index',
        name: 'Orders'
      },
      {
        controller: '/spree/admin/products',
        action: 'index',
        name: 'Products'
      },
      {
        controller: '/spree/admin/stock_items',
        action: 'index',
        name: 'Stock'
      }
    ]
  }
}

if defined?(Spree::Auth::Engine)
  alchemy_module[:navigation][:sub_navigation].push(
    {
      controller: '/spree/admin/users',
      action: 'index',
      name: 'Users'
    }
  )
  Alchemy.user_class_name = 'Spree::User'
  Alchemy.current_user_method = :spree_current_user

  if Alchemy.respond_to?(:logout_method)
    Rails.application.config.after_initialize do
      Alchemy.logout_method = Devise.sign_out_via
    end
  end
end

Rails.application.config.after_initialize do
  Alchemy::Modules.register_module(alchemy_module)
  Alchemy.link_dialog_tabs.add(Alchemy::Admin::LinkDialog::ProductTab)
end
