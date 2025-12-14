# Input Component
# Universal input component with design tokens support.
# Provides text input with label, optional icon, required indicator, and accessibility features.
# See input_component.html.erb for template and input_component.scss for styles.

class Input::InputComponent < ViewComponent::Base
  # Initialize input component with label, name, and optional parameters
  def initialize(
    label:,
    name:,
    id: nil,
    placeholder: nil,
    required: false,
    icon: nil,
    size: :medium,
    type: "text",
    value: nil,
    disabled: false,
    error: nil,
    **options
  )
    @label = label
    @name = name
    @id = id || generate_id_from_name(name)
    @placeholder = placeholder
    @required = required
    @icon = icon
    @size = size
    @type = type
    @value = value
    @disabled = disabled
    @error = error
    @options = options
  end

  private

  attr_reader :label, :name, :id, :placeholder, :required, :icon, :size, :type, :value, :disabled, :error, :options

  # Check if input has an icon
  def has_icon?
    icon.present?
  end

  # Check if input is required (shows asterisk)
  def required?
    required
  end

  # Check if input has an error
  def has_error?
    error.present?
  end

  # Generate CSS classes for wrapper
  def wrapper_classes
    classes = ["input-wrapper"]
    classes << "input-wrapper-#{size}" unless size == :medium
    classes << "input-wrapper-error" if has_error?
    classes << options[:wrapper_class] if options[:wrapper_class]
    classes.compact.join(" ")
  end

  # Generate CSS classes for input element
  def input_classes
    classes = ["input"]
    classes << "input-#{size}" unless size == :medium
    classes << "input-with-icon" if has_icon?
    classes << options[:class] if options[:class]
    classes.compact.join(" ")
  end

  # Generate HTML attributes hash for input element
  def input_attributes
    attrs = {}
    attrs[:id] = id
    attrs[:name] = name
    attrs[:type] = type
    attrs[:class] = input_classes
    attrs[:placeholder] = placeholder if placeholder
    attrs[:value] = value if value
    attrs[:required] = true if required?
    attrs[:disabled] = true if disabled
    
    # Autocomplete attribute - use explicit value or auto-detect
    autocomplete_value = options[:autocomplete] || auto_detect_autocomplete
    attrs[:autocomplete] = autocomplete_value if autocomplete_value
    
    # Merge ARIA attributes
    if options[:aria]
      options[:aria].each { |k, v| attrs["aria-#{k}".to_sym] = v }
    end
    
    # Merge data attributes
    if options[:data]
      options[:data].each { |k, v| attrs["data-#{k}".to_sym] = v }
    end
    
    attrs
  end

  # Auto-detect autocomplete value based on type and name
  def auto_detect_autocomplete
    # Password fields
    return "current-password" if type == "password"
    
    # Email fields
    return "email" if type == "email" || name.to_s.match?(/email|mail/i)
    
    # Username fields
    return "username" if name.to_s.match?(/username|user_name|user-name|login/i)
    
    # Name fields
    return "name" if name.to_s.match?(/^name$|^full_name$|full-name/i)
    return "given-name" if name.to_s.match?(/first_name|first-name|given_name|given-name|fname/i)
    return "family-name" if name.to_s.match?(/last_name|last-name|family_name|family-name|lname|surname/i)
    
    # Phone fields
    return "tel" if type == "tel" || name.to_s.match?(/phone|tel|mobile/i)
    
    # Other common fields
    return "organization" if name.to_s.match?(/company|organization|org/i)
    return "address-line1" if name.to_s.match?(/address|street/i)
    return "country" if name.to_s.match?(/country/i)
    return "postal-code" if name.to_s.match?(/zip|postal|postcode/i)
    
    nil
  end

  # Render icon SVG by loading from assets/images/icons/ directory
  def render_icon
    icon_path = Rails.root.join("app/assets/images/icons/#{icon}-icon.svg")
    
    if File.exist?(icon_path)
      svg_content = File.read(icon_path)
      # Remove width/height attributes to allow scaling
      svg_content = svg_content.gsub(/\s(width|height)=["'][^"']*["']/, '')
      # Ensure SVG inherits size and color from parent
      svg_content = svg_content.gsub(/<svg/, '<svg style="width: 100%; height: 100%;" class="input-icon-svg"')
      svg_content.html_safe
    else
      nil
    end
  end

  # Generate ID from name attribute (converts "user[email]" to "user_email")
  def generate_id_from_name(name)
    name.to_s.gsub(/\[|\]/, '_').gsub(/__/, '_').gsub(/_$/, '')
  end
end

