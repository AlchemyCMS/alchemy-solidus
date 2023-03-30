if defined?(Alchemy::Devise::Engine)
  Spree.user_class = "Alchemy::User"
end
