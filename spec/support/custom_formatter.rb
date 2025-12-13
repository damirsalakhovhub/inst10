# Custom RSpec formatter with emoji indicators
module RSpec::Core::Formatters
  class CustomFormatter
    RSpec::Core::Formatters.register self, :example_passed, :example_failed, :example_pending, :dump_summary, :example_group_started

    def initialize(output)
      @output = output
      @current_group = nil
    end

    def example_group_started(notification)
      group = notification.group
      if group.parent_groups.size == 1
        @output.puts "\n#{group.description}"
        @current_group = group.description
      end
    end

    def example_passed(notification)
      @output.puts "  ✅ #{notification.example.description}"
    end

    def example_failed(notification)
      @output.puts "  ❌ #{notification.example.description}"
      @output.puts "     #{notification.exception.message.split("\n").first}"
    end

    def example_pending(notification)
      @output.puts "  ⏸️  #{notification.example.description}"
    end

    def dump_summary(notification)
      @output.puts "\nFinished in #{notification.duration.round(2)} seconds"
      @output.puts "#{notification.example_count} examples, #{notification.failure_count} failures"
    end
  end
end

