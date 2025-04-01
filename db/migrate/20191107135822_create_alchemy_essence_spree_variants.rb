class CreateAlchemyEssenceSpreeVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :alchemy_essence_spree_variants do |t|
      t.references :variant, null: true, foreign_key: {to_table: Spree::Variant.table_name}

      t.timestamps
    end
  end
end
