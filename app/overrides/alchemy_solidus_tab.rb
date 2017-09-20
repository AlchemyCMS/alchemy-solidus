Deface::Override.new(
  virtual_path: "spree/admin/shared/_menu",
  name: "alchemy_cms_tab",
  insert_bottom: '[data-hook="admin_tabs"]',
  partial: "alchemy/admin/shared/alchemy_solidus_tab",
  original: 'b7b242ee058673679949d7e3050be5974938294d'
)

Deface::Override.new(
  virtual_path: "spree/admin/shared/_product_tabs",
  name: "alchemy_product_tab",
  insert_bottom: '[data-hook="admin_product_tabs"]',
  partial: "alchemy/admin/shared/alchemy_product_tab"
)
