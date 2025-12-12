class ExampleJob < ApplicationJob
  queue_as :default

  # Example background job using Solid Queue
  # This job demonstrates:
  # - Retry logic
  # - Error handling
  # - Logging

  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(user_id)
    user = User.find(user_id)

    Rails.logger.info "Processing example job for user #{user.email}"

    # Simulate some work
    sleep 1

    # Example: Send welcome email, process data, etc.
    # UserMailer.welcome_email(user).deliver_later

    Rails.logger.info "Example job completed for user #{user.email}"
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "User not found: #{e.message}"
    # Don't retry if user doesn't exist
  end
end
