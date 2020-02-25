Spree::Admin::BaseController.unauthorized_redirect = -> do
  if try_spree_current_user
    flash[:error] = I18n.t('spree.authorization_failure')
    redirect_to spree.root_path
  else
    store_location
    redirect_to Alchemy.login_path
  end
end
