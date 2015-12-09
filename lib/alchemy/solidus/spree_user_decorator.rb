Spree::User.class_eval do

  def alchemy_roles
    if has_spree_role?(:admin)
      %w(admin)
    else
      []
    end
  end
end
