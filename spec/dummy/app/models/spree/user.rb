# frozen_string_literal: true

require "alchemy/solidus/spree_user_extension"

class Spree::User < ActiveRecord::Base
  include Alchemy::Solidus::SpreeUserExtension
end
