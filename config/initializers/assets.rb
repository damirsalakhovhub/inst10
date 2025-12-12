# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Sass load paths
# - design system styles: packages/design_system/app/assets/stylesheets
# - design system components (SCSS living next to ViewComponents): packages/design_system/app
Rails.application.config.dartsass.build_options = [
  "--load-path=packages/design_system/app/assets/stylesheets",
  "--load-path=packages/design_system/app",
  "--load-path=app"
]

# Add design_system to Sass load paths
Rails.application.config.dartsass.build_options = ["--load-path=app", "--load-path=design_system/app"]
