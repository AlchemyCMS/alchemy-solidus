# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alchemy::Solidus::SpreeUserPatch, type: :model do
  let(:spree_user) do
    Class.new(ActiveRecord::Base) do
      def self.name
        "Spree::User"
      end

      include Alchemy::Solidus::SpreeUserPatch
    end
  end

  let(:user) { spree_user.new(email: "spree@example.com") }

  describe "#alchemy_display_name" do
    it "returns user's email" do
      expect(user.alchemy_display_name).to eq "spree@example.com"
    end
  end
end
