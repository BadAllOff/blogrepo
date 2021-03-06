require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV['RAILS_ADMIN_THEME'] = 'rollincode'

module Badblog5
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Warsaw'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    I18n.available_locales = [:ru, :en]

    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:ru]

    config.autoload_paths += %W( #{config.root}/app/decorators)

    config.generators do |g|
      g.test_framework :rspec,
      fixtures: true,
      view_spec: false,
      helper_specs: false,
      routing_specs: false,
      request_specs: false,
      controller_specs: true
      g.fixtures_replacement :factory_girl, dir: 'spec/factory'
    end

    # config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    # config.assets.precompile += Ckeditor.assets
    # config.assets.precompile += %w(ckeditor/*)
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  end
end
