require 'generators/spree/install/install_generator'

Spree::InstallGenerator.class_eval do
  CORE_MOUNT_ROUTE = "mount Spree::Core::Engine"

  def install_routes
    routes_file_path = File.join('config', 'routes.rb')
    unless File.read(routes_file_path).include? CORE_MOUNT_ROUTE
      insert_into_file routes_file_path, after: "Rails.application.routes.draw do\n" do
        <<-ROUTES
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  #{CORE_MOUNT_ROUTE}, at: '/'

ROUTES
      end
    end

    unless options[:quiet]
      puts "*" * 50
      puts "We added the following line to your application's config/routes.rb file:"
      puts " "
      puts "    #{CORE_MOUNT_ROUTE}, at: '/'"
    end
  end
end
