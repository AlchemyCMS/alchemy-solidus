require 'active_record/migration'
require 'generators/spree/custom_user/custom_user_generator'

Spree::CustomUserGenerator.class_eval do
  def self.next_migration_number(dirname)
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end
end
