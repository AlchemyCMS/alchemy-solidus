class CreateAlchemyEssenceSpreeProducts < ActiveRecord::Migration[4.2]
	def change
		create_table 'alchemy_essence_spree_products' do |t|
			t.integer :spree_product_id
		end
		add_index :alchemy_essence_spree_products, :spree_product_id
	end
end
