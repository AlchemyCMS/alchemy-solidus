# frozen_string_literal: true

require "rails_helper"
require "alchemy/solidus/spree_user_extension"

RSpec.describe Alchemy::Solidus::SpreeUserExtension, type: :model do
  let(:spree_user) do
    Class.new(ActiveRecord::Base) do
      def self.name
        "Spree::User"
      end

      def has_spree_role?(_role)
        false
      end

      include Alchemy::Solidus::SpreeUserExtension
    end
  end

  let(:user) { spree_user.new(email: "spree@example.com") }

  describe "#alchemy_roles" do
    context "when user is an admin" do
      it "returns an array with the admin role" do
        allow(user).to receive(:has_spree_role?).with(:admin).and_return(true)
        expect(user.alchemy_roles).to eq %w[admin]
      end
    end

    context "when user is not an admin" do
      it { expect(user.alchemy_roles).to be_empty }
    end
  end

  describe "#alchemy_display_name" do
    context "when user is not an admin" do
      it "returns user's email" do
        expect(user.alchemy_display_name).to eq "spree@example.com"
      end
    end
  end
end
