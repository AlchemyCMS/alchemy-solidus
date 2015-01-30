# Alchemy CMS Spree Extension

The World's Most Flexible E-Commerce Platform meets The World's Most Flexible Content Management System!

This gem is a [Alchemy CMS](https://github.com/magiclabs/alchemy_cms) and [Spree](https://github.com/spree/spree) connector.

### For now it does this:

1. It provides an Alchemy module that displays Spree admin in an iframe inside Alchemy admin.
2. It gives you new Essences for Alchemy called EssenceSpreeProduct and EssenceSpreeTaxon that you can use to place a Spree product and Taxon on your pages.
3. Shares admin session between Alchemy and Spree.

### Compatibility

## Spree

This version runs with Spreecommerce 2.1 and above.

## Alchemy

This version runs with Alchemy 3.0 and above.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alchemy_spree', github: 'magiclabs/alchemy_spree', branch: 'master'
```

Install the gem with:

```shell
$ bundle install
```

### Authentication system installation

Both Alchemy 3.0 and Spree come without an authentication system in place. You will need to choose an authentication system yourself. There are 3 available options. Whichever you choose, you need to instruct Spree & Alchemy about your choice of authentication system.

Here are the steps for each option:

#### 1. Option: Use [Spree Auth Devise](https://github.com/spree/spree_auth_devise)

**Recommended for:**
  - An existing Spree installation (`gem 'spree_auth_devise'` should already be in your Gemfile).
  - You are just adding Alchemy

To use Spree Auth Devise, instruct Alchemy to use the `Spree::User` class:

```ruby
# config/initializers/alchemy.rb

# Tell Alchemy to use the Spree::User class
Alchemy.user_class_name = 'Spree::User'
Alchemy.current_user_method = :spree_current_user

# Load the Spree.user_class decorator for Alchemy roles
require 'alchemy/spree/spree_user_decorator'

# Include the Spree controller helpers to render the
# alchemy pages within the default Spree layout
Alchemy::BaseHelper.send :include, Spree::BaseHelper
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Common
Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Store
```

#### 2. Option: Use [Alchemy Devise](https://github.com/magiclabs/alchemy-devise)

**Recommended for:**
  - An existing Alchemy installation
  - You don't have an authentication system and don't want to role an authentication system on your own.

Add `alchemy-devise` to your `Gemfile`

```ruby
# Gemfile
gem 'alchemy-devise', '~> 2.0'
```

and install it:

```shell
$ bundle install
$ bundle exec rails g alchemy:devise:install
```

Run the Spree installer:

*NOTE*: Skip this if you already have a running Spree installation.

```shell
$ bundle exec rails g spree:install
```

Then run the spree custom user generator:

```shell
$ bundle exec rails g spree:custom_user Alchemy::User
```

Now you'll need to instruct Spree to use the Alchemy User class:

```ruby
# config/initializers/spree.rb
...
Spree.user_class = "Alchemy::User"
require 'alchemy/spree/alchemy_user_decorator'
...
```

and tell Spree about Alchemy's path helpers:

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

Please follow the [spree custom authentication](https://guides.spreecommerce.com/developer/authentication.html) and the [Alchemy custom authentication](http://guides.alchemy-cms.com/edge/custom_authentication.html) guides in order to integrate your custom user with Spree and Alchemy.

#### In either case

Install the migrations

```shell
$ bundle exec rake alchemy_spree:install:migrations
```

Run the installer of Alchemy

```shell
$ bundle exec rake alchemy:install
```

and follow the on screen instructions.

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

### You can haz Spree product and taxons!

```erb
# app/views/alchemy/elements/_product_view.html.erb
<%= element.ingredient('spree_product') %>

# app/views/alchemy/elements/_product_category_view.html.erb
<%= element.ingredient('spree_taxon') %>
```

Alchemy :heart: Spree!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
