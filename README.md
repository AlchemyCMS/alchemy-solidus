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

This version runs with Alchemy 3.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alchemy_spree', github: 'magiclabs/alchemy_spree', branch: 'master'
```

And then execute:

```sh
$ bundle
```

Install the migrations:

```sh
$ rake alchemy_spree:install:migrations
```

Do the next step before running the migrations.


### Authentication system installation

Both Alchemy 3.0 and Spree come without an authentication system in place. You will need to choose an authentication system yourself. There are 3 available options. Whichever you choose, you need to instruct Spree & Alchemy about your choice of authentication system. Here are the steps for each option:


1. Use [Spree Auth Devise](https://github.com/spree/spree_auth_devise)

  Recommended for:
    - an existing Spree installation. `gem 'spree_auth_devise'` should already be in your Gemfile.
    - you are just adding Alchemy


  To use Spree Auth Devise, instruct Alchemy to use the Spree Auth Devise user class:

  ```ruby
  # config/initializers/alchemy.rb
  Alchemy.user_class_name = 'Spree::User'
  Alchemy.current_user_method = :spree_current_user

  # Include the Spree controller helpers to render the
  # alchemy pages within the default Spree layout
  Alchemy::BaseHelper.send :include, Spree::BaseHelper
  Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Common
  Alchemy::BaseController.send :include, Spree::Core::ControllerHelpers::Store
  ```

2. Use [Alchemy Devise](https://github.com/magiclabs/alchemy-devise)

  Recommended for:
    - an existing Alchemy installation
    - you don't have an authentication system and don't want to role an authentication system on your own.


  To install alchemy-devise:

  ```ruby
  # Gemfile
  gem 'alchemy-devise', '~> 2.0'
  ```

  And then execute:

  ```sh
  $ bundle
  ```

  Finally, you'll need to instruct Spree to use the Alchemy Devise user class:

  ```ruby
  # config/initializers/spree.rb
  Spree.user_class = "Alchemy::User"
  ```

3. Build their own authentication


---

In either case, run the migrations now:

```sh
$ rake db:migrate
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
