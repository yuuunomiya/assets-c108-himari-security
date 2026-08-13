require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja
    # config.eager_load_paths << Rails.root.join("extras")

    # 脆弱性を含まないバージョン（安全・参考用）:
    # config.load_defaults 7.0以降の既定値は:raiseになっており、
    # redirect_toが自分と異なるホストへ遷移しようとした際に例外を送出して
    # オープンリダイレクトを未然に防いでくれる。
    #
    # config.action_controller.action_on_open_redirect = :raise

    # 第9章: オープンリダイレクト（現在有効）:
    # Railsが標準で備えているこの安全機構を:logに緩めてしまっているため、
    # 警告をログに残すだけでリダイレクト自体は素通りしてしまう。
    # そのため、after_sign_in_path_forが外部URLを返すとそのまま遷移してしまう。
    config.action_controller.action_on_open_redirect = :log
  end
end
