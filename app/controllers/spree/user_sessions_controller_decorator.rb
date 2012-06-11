if defined? Spree::UserSessionsController
  Spree::UserSessionsController.class_eval do
    include AlchemySpree::AlchemyLanguageStore
  end
end
