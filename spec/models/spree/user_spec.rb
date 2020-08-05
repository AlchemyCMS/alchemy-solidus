# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spree::User do
  it { is_expected.to have_many(:folded_pages).class_name("Alchemy::FoldedPage") }
end
