if defined? Spree::UserSessionsController
  Spree::UserSessionsController.class_eval do
    include AlchemyCrm::AlchemyLanguageIdStore
  end
end
