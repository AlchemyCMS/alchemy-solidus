Deface::Override.new(
  virtual_path: "spree/admin/shared/_menu",
  name: "alchemy_cms_tab",
  insert_bottom: '[data-hook="admin_tabs"]',
  partial: "alchemy/admin/shared/alchemy_solidus_tab"
)
