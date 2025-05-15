# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spree::StoreController do
  it "includes Alchemy modules" do
    expect(described_class.ancestors).to include(Alchemy::ConfigurationMethods)
    expect(described_class.ancestors).to include(Alchemy::ControllerActions)
  end
end
