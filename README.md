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

Migrate the database:

```sh
$ rake db:migrate
```

### Authentication system installation

Since Alchemy 3.0 has dropped the authentication from its core, you will need to choose one authentication system. The easiest choice is to use the [alchemy-devise gem](https://github.com/magiclabs/alchemy-devise).

To install alchemy-devise:

```ruby
# Gemfile
gem 'alchemy-devise', '~> 2.0'
```

And then execute:

```sh
$ bundle
```

Finally, you'll need to instruct Spree accordingly:

```ruby
# config/initializers/spree.rb
Spree.user_class = "Alchemy::User"
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
