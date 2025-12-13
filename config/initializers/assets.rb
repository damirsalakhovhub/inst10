# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Add UI kit and views to Sass load paths
Rails.application.config.dartsass.build_options = ["--load-path=app", "--load-path=ui_kit", "--load-path=app/views"]
