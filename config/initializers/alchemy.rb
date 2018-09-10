alchemy_module = {
  engine_name: 'spree',
  name: 'solidus',
  navigation: {
    controller: 'spree/admin/orders',
    action: 'index',
    name: 'Store',
    image: 'alchemy/solidus/alchemy_module_icon.png',
    sub_navigation: [
      {
        controller: 'spree/admin/orders',
        action: 'index',
        name: 'Orders'
      },
      {
        controller: 'spree/admin/products',
        action: 'index',
        name: 'Products'
      },
      {
        controller: 'spree/admin/reports',
        action: 'index',
        name: 'Reports'
      },
      {
        controller: 'spree/admin/promotions',
        action: 'index',
        name: 'Promotions'
      },
      {
        controller: 'spree/admin/stock_items',
        action: 'index',
        name: 'Stock'
      }
    ]
  }
}

if defined?(Spree::Auth::Engine)
  alchemy_module[:navigation][:sub_navigation].push(
    {
      controller: 'spree/admin/users',
      action: 'index',
      name: 'Users'
    }
  )
end

Alchemy::Modules.register_module(alchemy_module)
