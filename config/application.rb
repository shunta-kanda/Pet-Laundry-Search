# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    if Gem.loaded_specs.key?('bootstrap')
      config.assets.paths << "#{Gem.loaded_specs['bootstrap'].full_gem_path}/assets/stylesheets"
    end
    if Gem.loaded_specs.key?('bootstrap-icons')
      config.assets.paths << File.join(Gem.loaded_specs['bootstrap-icons'].full_gem_path, 'app', 'assets',
                                       'stylesheets')
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
