# Alchemy CMS Spree Connector

The World's Most Flexible E-Commerce Platform meets The World's Most Flexible Content Management System!

This gem is a [Alchemy CMS](https://github.com/magiclabs/alchemy_cms) and [Spree](https://github.com/spree/spree) connector.

It provides buttons in each admin panels to switch to each other and a new essence for Alchemy called EssenceSpreeProduct that you can use to place a Spree product on your page.

## Installation

Add this line to your application's Gemfile:

    gem 'alchemy_spree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alchemy_spree

## Usage

### Create a new element for Alchemy

	# config/alchemy/elements.yml
	- name: product
	  contents:
	  - name: spree_product
	    type: EssenceSpreeProduct

### Generate the views

	$ rails g alchemy:elements --skip

### Allow this element on a page layout

	# config/alchemy/page_layouts.yml
	- name: products
	  elements: [product]

### You can haz Spree product!

	# app/views/alchemy/elements/_product_view.html.erb
	<%= element.ingredient('spree_product') %>

Alchemy <3 Spree

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
