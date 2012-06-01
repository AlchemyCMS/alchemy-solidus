module Alchemy
  User.class_eval do

    def spree_roles
      @spree_admin_role ||= Spree::Role.find_or_create_by_name("admin")
      if admin?
        [@spree_admin_role]
      else
        []
      end
    end

  end
end
