Alchemy::Modules.register_module({
  name: 'spree',
  navigation: {
    controller: 'alchemy/admin/spree',
    action: 'index',
    name: 'Spree',
    image: '/assets/alchemy_spree/alchemy_module_icon.png'
  }
})

Alchemy::Auth::Engine.get_instance.load(File.join(File.dirname(__FILE__), '../..', 'config/authorization_rules.rb'))
