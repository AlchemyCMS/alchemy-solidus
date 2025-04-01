if defined?(Alchemy::Devise::Engine)
  Spree.user_class = "Alchemy::User"
end

Rails.application.config.after_initialize do
  Spree::Backend::Config.configure do |config|
    alchemy_menu_item = if Spree.solidus_gem_version >= Gem::Version.new("4.2.0")
      config.class::MenuItem.new(
        label: :cms,
        icon: config.admin_updated_navbar ? "ri-pages-line" : "copy",
        condition: -> { can?(:index, :alchemy_admin_dashboard) },
        url: -> { Alchemy::Engine.routes.url_helpers.admin_dashboard_path },
        children: [
          config.class::MenuItem.new(
            label: :pages,
            condition: -> { can?(:index, :alchemy_admin_pages) },
            url: -> { Alchemy::Engine.routes.url_helpers.admin_pages_path },
            match_path: "/pages"
          ),
          config.class::MenuItem.new(
            label: :languages,
            condition: -> { can?(:index, :alchemy_admin_sites) },
            url: -> { Alchemy::Engine.routes.url_helpers.admin_sites_path },
            match_path: "/languages"
          ),
          (if defined?(Alchemy::Devise::Engine)
             config.class::MenuItem.new(
               label: :users,
               condition: -> { can?(:index, :alchemy_admin_users) },
               url: -> { Alchemy::Engine.routes.url_helpers.admin_users_path },
               match_path: "/users"
             )
           end),
          config.class::MenuItem.new(
            label: :tags,
            condition: -> { can?(:index, :alchemy_admin_tags) },
            url: -> { Alchemy::Engine.routes.url_helpers.admin_tags_path }
          ),
          config.class::MenuItem.new(
            label: :pictures,
            condition: -> { can?(:index, :alchemy_admin_pictures) },
            url: -> { Alchemy::Engine.routes.url_helpers.admin_pictures_path }
          ),
          config.class::MenuItem.new(
            label: :attachments,
            condition: -> { can?(:index, :alchemy_admin_attachments) },
            url: -> { Alchemy::Engine.routes.url_helpers.admin_attachments_path }
          )
        ].compact
      )
    else
      config.class::MenuItem.new(
        [:pages, :sites, :languages, :tags, :users, :pictures, :attachments],
        "copy",
        label: :cms,
        condition: -> { can?(:index, :alchemy_admin_dashboard) },
        partial: "spree/admin/shared/alchemy_sub_menu",
        url: "/admin/pages",
        match_path: "/pages"
      )
    end
    settings = config.menu_items.detect { |item| item.label == :settings }
    config.menu_items.index(settings).tap do |index|
      config.menu_items.insert(index, alchemy_menu_item)
    end
  end

  if Spree::Backend::Config.menu_items.many? { |menu_item| menu_item.label == :cms }
    Alchemy::Deprecation.warn("You configured the Alchemy menu items in your app's initializers. We can do that for you now! Please remove the menu item with the label `:cms`.")
  end
end
