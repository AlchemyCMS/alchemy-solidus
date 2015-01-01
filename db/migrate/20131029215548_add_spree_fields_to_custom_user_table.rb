class AddSpreeFieldsToCustomUserTable < ActiveRecord::Migration
  def up
    if ::Spree.user_class == "Alchemy::User"
      add_column "alchemy_users", :spree_api_key, :string, :limit => 48
      add_column "alchemy_users", :ship_address_id, :integer
      add_column "alchemy_users", :bill_address_id, :integer
    end
  end
end
