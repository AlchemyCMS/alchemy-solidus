# frozen_string_literal: true

require "rails_helper"
require "tmpdir"
require "generators/alchemy/solidus/install/install_generator"

RSpec.describe Alchemy::Solidus::InstallGenerator do
  describe "#run_alchemy_user_columns_generator" do
    around do |example|
      Dir.mktmpdir("alchemy-solidus-install-generator") do |dir|
        @destination_root = dir
        # The Alchemy user columns generator is invoked via `.start`, which
        # resolves its destination from the working directory, not from ours.
        Dir.chdir(dir) { example.run }
      end
    end

    attr_reader :destination_root

    let(:generator) do
      described_class.new([], {auto_accept: true}, destination_root: destination_root)
    end

    let(:add_columns_migration) do
      Dir.glob(File.join(destination_root, "db", "migrate", "*_add_alchemy_fields_to_spree_users_table.rb")).first
    end

    let(:set_roles_migration) do
      Dir.glob(File.join(destination_root, "db", "migrate", "*_set_alchemy_roles_on_spree_users_table.rb")).first
    end

    before do
      stub_const("Spree::User", Class.new(ActiveRecord::Base) do
        self.table_name = "spree_users"
      end)
      allow(generator).to receive(:rake)
      silence_stream { generator.run_alchemy_user_columns_generator }
    end

    def silence_stream
      original, $stdout = $stdout, StringIO.new
      yield
    ensure
      $stdout = original
    end

    it "adds the Alchemy columns to the Spree user table" do
      expect(add_columns_migration).to be_present
    end

    it "backfills the Alchemy roles on the Spree user table" do
      expect(set_roles_migration).to be_present
    end

    it "names the migration classes after their files" do
      expect(File.read(add_columns_migration)).to include(
        "class AddAlchemyFieldsToSpreeUsersTable < ActiveRecord::Migration"
      )
      expect(File.read(set_roles_migration)).to include(
        "class SetAlchemyRolesOnSpreeUsersTable < ActiveRecord::Migration"
      )
    end

    it "assigns the Alchemy roles as strings" do
      content = File.read(set_roles_migration)

      # `update_column` casts through the text column and raises on an Array.
      expect(content).to include('"admin"', '"member"')
      expect(content).to include("user.update_column(:alchemy_roles, alchemy_roles)")
    end
  end
end
