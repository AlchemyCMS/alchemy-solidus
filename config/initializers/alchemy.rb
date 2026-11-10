store_menu_children = [
  {title: "Orders", engine_name: "spree", controller: "/spree/admin/orders", action: "index"},
  {title: "Products", engine_name: "spree", controller: "/spree/admin/products", action: "index"},
  {title: "Stock", engine_name: "spree", controller: "/spree/admin/stock_items", action: "index"}
]

if defined?(Spree::Auth::Engine)
  store_menu_children.push(
    {title: "Users", engine_name: "spree", controller: "/spree/admin/users", action: "index"}
  )
  Alchemy.config.user_class = "Spree::User"
  Alchemy.config.current_user_method = :spree_current_user
  Rails.application.config.after_initialize do
    Alchemy.config.logout_method = Devise.sign_out_via.to_s
  end
end

Alchemy.configure do |config|
  config.menu.add(
    name: "solidus",
    title: "Store",
    engine_name: "spree",
    controller: "/spree/admin/orders",
    action: "index",
    icon: "shopping-cart",
    turbo: false,
    children: store_menu_children
  )
  config.link_dialog_tabs.add("Alchemy::Admin::LinkDialog::ProductTab")
end
