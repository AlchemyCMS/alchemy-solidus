alchemy_module = {
  engine_name: "spree",
  name: "solidus",
  navigation: {
    controller: "/spree/admin/orders",
    action: "index",
    name: "Store",
    icon: "shopping-cart",
    data: {turbolinks: false, turbo: false},
    sub_navigation: [
      {
        controller: "/spree/admin/orders",
        action: "index",
        name: "Orders"
      },
      {
        controller: "/spree/admin/products",
        action: "index",
        name: "Products"
      },
      {
        controller: "/spree/admin/stock_items",
        action: "index",
        name: "Stock"
      }
    ]
  }
}

if defined?(Spree::Auth::Engine)
  alchemy_module[:navigation][:sub_navigation].push(
    {
      controller: "/spree/admin/users",
      action: "index",
      name: "Users"
    }
  )
  Alchemy.config.user_class = "Spree::User"
  Alchemy.config.current_user_method = :spree_current_user
  Rails.application.config.after_initialize do
    Alchemy.config.logout_method = Devise.sign_out_via.to_s
  end
end

Rails.application.config.to_prepare do
  Alchemy::Modules.register_module(alchemy_module)
end

Alchemy.configure do |config|
  Alchemy.config.link_dialog_tabs.add("Alchemy::Admin::LinkDialog::ProductTab")
end
