# Preload UI kit components in development to avoid autoload issues in views
if Rails.env.development?
  Rails.application.config.to_prepare do
    # Force load UI kit components
    Dir[Rails.root.join("ui_kit/components/**/*_component.rb")].each do |file|
      require_dependency file
    end
  end
end

