require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DollarADay
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(
      #{config.root}/app/jobs
      #{config.root}/lib
      #{config.root}/lib/data
      #{config.root}/lib/core_ext
    )

    config.action_mailer.preview_path = "#{Rails.root}/app/mailers/previews"

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    initializer "dollaraday.load_lib_extensions", :before => :eager_load! do
      Rails.logger.info 'Loading ruby extensions'
      Dir["#{Rails.root}/lib/core_ext/**/*.rb"].each do |f| require f end
      Dir["#{Rails.root}/lib/ext/**/*.rb"].each do |f| require f end
      # TODO(@holman): Figure out what to do with this
      # Dir["#{Rails.root}/lib/network_for_good.rb"].each do |f| require f end
      # Dir["#{Rails.root}/lib/network_for_good/*.rb"].each do |f| require f end
    end
  end
end
