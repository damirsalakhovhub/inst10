# Dialog Component
# Modal dialog component with full accessibility support using native HTML5 dialog element.
# Provides centered dialog with backdrop, focus management, and keyboard navigation.
# See dialog_component.html.erb for template and dialog_component.scss for styles.

class Dialog::DialogComponent < ViewComponent::Base
  # Initialize dialog component with title and content
  def initialize(
    title:,
    body: nil,
    open: false,
    id: nil,
    **options
  )
    @title = title
    @body = body
    @open = open
    @id = id || generate_dialog_id
    @options = options
  end

  private

  attr_reader :title, :body, :open, :id, :options

  # Check if dialog should be open initially
  def open?
    open
  end

  # Generate unique dialog ID
  def generate_dialog_id
    "dialog-#{SecureRandom.hex(4)}"
  end

  # Generate dialog attributes
  def dialog_attributes
    attrs = {}
    attrs[:id] = id
    attrs[:role] = "dialog"
    attrs[:"aria-modal"] = "true"
    attrs[:"aria-labelledby"] = "#{id}-title"
    attrs[:open] = true if open?
    
    # Merge data attributes for Stimulus controller
    attrs[:"data-dialog-target"] = "dialog"
    attrs[:"data-action"] = "click->dialog#handleBackdropClick"
    
    # Merge additional options
    if options[:data]
      options[:data].each { |k, v| attrs["data-#{k}".to_sym] = v }
    end
    
    attrs
  end

  # Generate close button attributes
  def close_button_attributes
    {
      type: "button",
      class: "dialog-close",
      aria_label: "Close dialog",
      data: {
        action: "dialog#close"
      }
    }
  end

  # Title ID for aria-labelledby
  def title_id
    "#{id}-title"
  end
end

