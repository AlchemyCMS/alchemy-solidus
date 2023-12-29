[![CI](https://github.com/AlchemyCMS/alchemy-solidus/workflows/CI/badge.svg?branch=main)](https://github.com/AlchemyCMS/alchemy-solidus/actions?query=workflow%3ACI+branch%3Amain)
[![Gem Version](https://badge.fury.io/rb/alchemy-solidus.svg)](https://badge.fury.io/rb/alchemy-solidus)

# Sponsoring

Development and maintenance is sponsored by [Blish](https://blish.cloud/).

[![BLISH Logo](https://blish.cloud/BLISH_Logo.svg)](https://blish.cloud)

# Alchemy-Solidus

This is a [AlchemyCMS](https://alchemy-cms.com) and [Solidus](https://solidus.io) integration gem.

1. It provides tabs in Alchemy and Solidus menus to easily switch between both backends
2. It offers two new Essences for Alchemy called `EssenceSpreeProduct` and `EssenceSpreeTaxon` that you can use to place Spree products and/or Taxons on your pages.
3. Shares admin sessions and user abilities between Alchemy and Solidus.

## Compatibility

### Solidus

This version runs with Solidus v4.0 and up.

- For a Solidus 3.x compatible version please use the `6.3-stable` branch or `6.3.1` gem version.
- For a Solidus < 2.11 compatible version please use the `3.1-stable` branch or `3.3.0` gem version.
- For a Solidus < 2.6 compatible version please use the `2.3-stable` branch or `2.3.2` gem version.
- For a Solidus 1.x compatible version please use the `1.0-stable` branch or `1.1.0` gem version.

> **NOTE:** If you are using Solidus v3.0 with Alchemy v5.3, make sure to also use Rails v6.0 and the legacy image attachment adapter (paperclip) and not the active storage adapter, since this needs Rails >= 6.1 and Alchemy v5.3 is not Rails 6.1 compatible. You need Alchemy v6.0 for Rails >= 6.1.

### Alchemy

This version runs with Alchemy v7.0 and v7.1

- For a Alchemy 6.x compatible version please use the `5.0-stable` branch or `5.0` gem version.
- For a Alchemy 5.x compatible version please use the `4.1-stable` branch or `4.1` gem version.
- For a Alchemy 4.x compatible version please use the `3.1-stable` branch or `3.3` gem version.
- For a Alchemy 4.0 compatible version please use the `2.3-stable` branch or `2.3` gem version.
- For a Alchemy 3.x compatible version please use the `1.0-stable` branch or `1.1` gem version.

## Installation

Add this line to your applications `Gemfile`:

```ruby
gem 'alchemy-solidus', '~> 6.0'
```

Install the gem with:

```bash
$ bundle install
```

## Automated setup

**Recommended**

We ship a Rails generator that helps you to install this gem into your existing application.

```bash
$ bin/rails g alchemy:solidus:install
```

There are several options available, please check them with

```bash
$ bin/rails g alchemy:solidus:install --help
```

## Upgrading

To upgrade update the Gemfile and run the install generator again

```bash
$ bin/rails g alchemy:solidus:install
```

**NOTE** Please make sure to remove the `Alchemy::Modules.register_module` part from your `config/initializer/alchemy.rb` file if upgrading from 2.5.

## Manual setup (for advanced users)

For regular setups we recommend the [automated installer](#automated-setup) mentioned above. But if you know what you are doing and want to have full control over the integration you can also set this up manually.

### Authentication system installation

Both Alchemy and Solidus come without an authentication system in place. You will need to choose an authentication system yourself. There are 3 available options. Whichever you choose, you need to instruct Solidus & Alchemy about your choice of authentication system.

Here are the steps for each option:

#### 1. Option: Use [Solidus Auth Devise](https://github.com/solidusio/solidus_auth_devise)

**Recommended for:**
  - An existing Solidus installation (`gem 'solidus_auth_devise'` should already be in your Gemfile).
  - You are just adding Alchemy

To use Solidus Auth Devise, instruct Alchemy to use the `Spree::User` class:

```ruby
# config/initializers/alchemy.rb
Alchemy.user_class_name = 'Spree::User'
Alchemy.current_user_method = :spree_current_user
```

If you put Spree in it's own routing namespace (see below) you will want to
let Alchemy know these paths:

```ruby
# config/initializers/alchemy.rb
Alchemy.login_path = '/store/login'
Alchemy.logout_path = '/store/logout'
```

#### 2. Option: Use [Alchemy Devise](https://github.com/AlchemyCMS/alchemy-devise)

**Recommended for:**
  - An existing Alchemy installation
  - You don't have an authentication system and don't want to role an authentication system on your own.

Add `alchemy-devise` to your `Gemfile`

```ruby
# Gemfile
gem 'alchemy-devise', '~> 4.1'
```

and install it:

```bash
$ bundle install
$ bundle exec rails g alchemy:devise:install
```

Run the Solidus installer:

*NOTE*: Skip this if you already have a running Solidus installation.

```bash
$ bundle exec rails g spree:install
```

Then run the solidus custom user generator:

```bash
$ bundle exec rails g spree:custom_user Alchemy::User
```

Now you'll need to instruct Solidus to use the Alchemy User class:

```ruby
# config/initializers/spree.rb
...
Spree.user_class = "Alchemy::User"
...
```

and tell Solidus about Alchemy's path helpers:

```ruby
# lib/spree/authentication_helpers.rb
    ...
    def spree_login_path
      Alchemy.login_path
    end

    def spree_signup_path
      Alchemy.signup_path
    end

    def spree_logout_path
      Alchemy.logout_path
    end
    ...
```

#### 3. Option: Build your own authentication

Please follow the [Solidus custom authentication](https://guides.solidus.io/developers/users/custom-authentication.html) and the [Alchemy custom authentication](https://guides.alchemy-cms.com/custom_authentication.html) guides in order to integrate your custom user with Solidus and Alchemy.

### In either case

Install the migrations

```bash
$ bundle exec rake alchemy_solidus:install:migrations
```

Run the installer of Alchemy

```bash
$ bundle exec rake alchemy:install
```

and follow the on screen instructions.

### Render Alchemy Content in Solidus Layout

~~If you plan to render the Alchemy site in the Solidus layout add the following
to your initializer:~~

```ruby
# config/initializers/alchemy.rb
require 'alchemy/solidus/use_solidus_layout'
```

**NOTE:** Since v2.5.2 this is done automatically for you. If you upgraded from an older version you can safely remove this from your initializers.

### Render Alchemy Content in Solidus views

~~If you plan to render Alchemy content in your Solidus views (ie. a global header
or footer section), you need to include the Alchemy view helpers and language
store in your Solidus controllers with the following addition to your
initializer:~~

```ruby
# config/initializers/alchemy.rb
require 'alchemy/solidus/alchemy_in_solidus'
```

**NOTE:** Since v2.5.2 this is done automatically for you. If you upgraded from an older version you can safely remove this from your initializers.

### Routing

For routing you have a few options.

#### Place both engines in their own namespace:

```ruby
# config/routes.rb
mount Spree::Core::Engine => '/store'
mount Alchemy::Engine => '/pages'
```

#### Put Solidus at the root level and Alchemy in its own namespace:

```ruby
# config/routes.rb
mount Alchemy::Engine => '/pages'
mount Spree::Core::Engine => '/'
```

#### Put Alchemy at the root level and Solidus in its own namespace:

```ruby
# config/routes.rb
mount Spree::Core::Engine => '/store'
mount Alchemy::Engine => '/'
```

#### Put both engines in the root level

```ruby
# config/routes.rb

# Make Alchemy's root page have higher priority than Spree's root page
root to: 'alchemy/pages#index'

mount Spree::Core::Engine => '/'

# Must be last so it's catch-all route can render undefined paths
mount Alchemy::Engine => '/'
```

## Usage

Please make yourself familiar with AlchemyCMS by [reading the guidelines](https://guides.alchemy-cms.com)

### Create a new Element for Alchemy

```yaml
# config/alchemy/elements.yml
- name: product
  contents:
  - name: spree_product
    type: EssenceSpreeProduct

- name: product_category
  contents:
  - name: spree_taxon
    type: EssenceSpreeTaxon
```

### Generate the views

```sh
$ rails g alchemy:elements --skip
```

### Place this element on a page layout

```yaml
# config/alchemy/page_layouts.yml
- name: product
  elements: [product]
- name: products
  elements: [product_category]
```

### Access the Solidus product or taxon in your element views

You can mix Alchemy and Solidus content in the same view.

```erb
<!-- app/views/alchemy/elements/_product_view.html.erb -->
<% cache element do %>
  <%= element_view_for element do |el| %>
    <% product = el.ingredient(:spree_product) %>
    <h1><%= product.name %></h1>
    <p><%= product.description %></p>
    <%= el.render :text %>
    <%= el.render :image %>
  <% end %>
<% end %>
```

Or for a list of taxon products

```erb
<!-- app/views/alchemy/elements/_product_category_view.html.erb -->
<% cache element do %>
  <%= element_view_for element do |el| %>
    <h2><%= el.render :headline %></h2>
    <%= el.render :description %>

    <% taxon = el.ingredient(:spree_taxon) %>
    <% taxon.products.each do |product| %>
      <%= link_to product.name, spree.product_path(product) %>
    <% end %>
  <% end %>
<% end %>
```

Alchemy :heart: Solidus!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
