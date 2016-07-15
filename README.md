# Alchemy CMS Solidus Integration

The World's Most Flexible E-Commerce Platform meets The World's Most Flexible Content Management System!

This gem is a [Alchemy CMS](https://github.com/AlchemyCMS/alchemy_cms) and [Solidus](https://github.com/solidusio/solidus) connector.

### For now it does this:

1. It provides tabs in Alchemy and Solidus menus to easily switch between both backends
2. It offers two new Essences for Alchemy called `EssenceSpreeProduct` and `EssenceSpreeTaxon` that you can use to place Spree products and/or Taxons on your pages.
3. Shares admin sessions and user abilities between Alchemy and Solidus.

### Compatibility

## Solidus

This version runs with Solidus 1.0 and above.

## Alchemy

This version runs with Alchemy 3.2 and above.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alchemy-solidus', github: 'AlchemyCMS/alchemy-solidus', branch: 'master'
```

Install the gem with:

```shell
$ bundle install
```

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
gem 'alchemy-devise', '~> 3.2'
```

and install it:

```shell
$ bundle install
$ bundle exec rails g alchemy:devise:install
```

Run the Solidus installer:

*NOTE*: Skip this if you already have a running Solidus installation.

```shell
$ bundle exec rails g spree:install
```

Then run the solidus custom user generator:

```shell
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
      alchemy.login_path
    end

    def spree_signup_path
      alchemy.signup_path
    end

    def spree_logout_path
      alchemy.logout_path
    end
    ...
```

#### 3. Option: Build their own authentication

Please follow the [spree custom authentication](https://guides.spreecommerce.com/developer/authentication.html) and the [Alchemy custom authentication](http://guides.alchemy-cms.com/edge/custom_authentication.html) guides in order to integrate your custom user with Solidus and Alchemy.

#### In either case

Install the migrations

```shell
$ bundle exec rake alchemy_solidus:install:migrations
```

Run the installer of Alchemy

```shell
$ bundle exec rake alchemy:install
```

and follow the on screen instructions.

### Render Alchemy Content in Solidus Layout

If you plan to render the Alchemy site in the Solidus layout add the following
to your initializer:

```ruby
# config/initializers/alchemy.rb
require 'alchemy/solidus/use_solidus_layout'
```

### Render Alchemy Content in Solidus views

If you plan to render Alchemy content in your Solidus views (ie. a global header
or footer section), you need to include the Alchemy view helpers and language
store in your Solidus controllers with the following addition to your
initializer:

```ruby
# config/initializers/alchemy.rb
require 'alchemy/solidus/alchemy_in_solidus'
```

## Routing

For routing you have a few options.

### Place both engines in their own namespace:

```ruby
# config/routes.rb
mount Spree::Core::Engine => '/store'
mount Alchemy::Engine => '/pages'
```

### Put Solidus at the root level and Alchemy in its own namespace:

```ruby
# config/routes.rb
mount Alchemy::Engine => '/pages'
mount Spree::Core::Engine => '/'
```

### Put Alchemy at the root level and Solidus in its own namespace:

```ruby
# config/routes.rb
mount Spree::Core::Engine => '/store'
mount Alchemy::Engine => '/'
```

### Put both engines in the root level

```ruby
# config/routes.rb

# Make Alchemy's root page have higher priority than Spree's root page
root to: 'alchemy/pages#show'

mount Spree::Core::Engine => '/'

# Must be last so it's catch-all route can render undefined paths
mount Alchemy::Engine => '/'
```

## Usage

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

### You can haz Solidus product and taxons!

```erb
# app/views/alchemy/elements/_product_view.html.erb
<%= element.ingredient('spree_product') %>

# app/views/alchemy/elements/_product_category_view.html.erb
<%= element.ingredient('spree_taxon') %>
```

Alchemy :heart: Solidus!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
