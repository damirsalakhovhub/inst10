# Disable automatic screenshots for system tests (requires selenium)
# We use rack_test which doesn't support screenshots

RSpec.configure do |config|
  config.before(:suite) do
    module ActionDispatch::SystemTesting::TestHelpers::ScreenshotHelper
      def take_failed_screenshot
        # Disabled - we use rack_test which doesn't support screenshots
      end
    end
  end
end

