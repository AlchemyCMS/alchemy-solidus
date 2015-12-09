Alchemy::Modules.register_module({
  engine_name: 'spree',
  name: 'solidus',
  navigation: {
    controller: 'spree/admin/orders',
    action: 'index',
    name: 'Shop',
    image: 'alchemy/solidus/alchemy_module_icon.png'
  }
})
