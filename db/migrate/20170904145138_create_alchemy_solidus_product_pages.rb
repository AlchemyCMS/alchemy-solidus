class CreateAlchemySolidusProductPages < ActiveRecord::Migration[5.0]
  def change
    create_table :alchemy_solidus_product_pages do |t|
      t.references :product, foreign_key: { to_table: :spree_products }, index: true
      t.references :page,    foreign_key: { to_table: :alchemy_pages },  index: true
    end
  end
end
