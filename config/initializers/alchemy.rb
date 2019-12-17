alchemy_module = {
  engine_name: 'spree',
  name: 'solidus',
  navigation: {
    controller: 'spree/admin/orders',
    action: 'index',
    name: 'Store',
    inline_image: '<svg version="1.1" width="24px" height="24px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" style="vertical-align: middle">
      <path d="M 6.687 21.839 L 17.314 21.839 L 17.314 2.162 L 6.687 2.162 Z M 19.476 24 L 4.525 24 L 4.525 0 L 19.476 0 Z M 13.89 17 C 13.307 16.662 13.078 16.287 13.05 15.313 L 13.05 8.574 C 13.05 6.554 12.05 5.814 9.911 4.794 L 8.99 6.434 L 10.111 7.074 C 10.693 7.412 10.923 7.786 10.951 8.761 L 10.951 15.5 C 10.951 17.52 11.951 18.26 14.09 19.279 L 15.01 17.64 Z" fill="currentColor"/>
    </svg>',
    data: { turbolinks: false },
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
  Alchemy.user_class_name = 'Spree::User'
  Alchemy.current_user_method = :spree_current_user
end

Alchemy::Modules.register_module(alchemy_module)
