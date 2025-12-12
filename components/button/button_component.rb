# Button Component
# Universal button component with design tokens support.
# Provides flexible button rendering with text, icons, variants (basic, primary, secondary, etc.),
# sizes (tiny, small, medium, large, xlarge), and accessibility features.
# See button_component.html.erb for template and button_component.scss for styles.

class Button::ButtonComponent < ViewComponent::Base
  # Initialize button component with optional text, icon, variant, size, and other options
  # **options - collects all extra keyword arguments into a hash (e.g., id:, class:, disabled:)
  def initialize(
    text: nil,
    type: "button",
    variant: :basic,
    size: :medium,
    icon: nil,
    icon_position: :left,
    icon_mode: :with_text,
    rounded: false,
    **options
  )
    # @text - instance variable, stores data for this specific component instance
    @text = text
    @type = type
    @variant = variant
    @size = size
    @icon = icon
    @icon_position = icon_position
    @icon_mode = icon_mode
    @rounded = rounded
    @options = options
  end
 

  # Everything below 'private' is only accessible within this class, not from outside
  private

  # attr_reader - creates getter methods automatically (e.g., def text; @text; end)
  # Allows methods to access instance variables without @ prefix
  attr_reader :text, :type, :variant, :size, :icon, :icon_position, :icon_mode, :rounded, :options

  # Check if button has an icon
  # .present? - Rails method, returns true if value exists and is not blank
  def has_icon?
    icon.present?
  end

  # Check if button is in icon-only mode (no text)
  def icon_only?
    icon_mode == :icon_only
  end

  # Check if text should be displayed (text present and not icon-only mode)
  def show_text?
    text.present? && !icon_only?
  end

  # Generate CSS classes for button based on variant, size, and modifiers
  # classes << - adds element to array (same as classes.push)
  def button_classes
    classes = ["btn"]
    # Only add variant class if it's not basic (basic is default, no class needed)
    classes << "btn-#{variant}" unless variant == :basic
    # Only add size class if it's not medium (medium is default, no class needed)
    classes << "btn-#{size}" unless size == :medium
    classes << "btn-icon-only" if icon_only?
    classes << "btn-rounded" if rounded
    classes << options[:class] if options[:class]
    classes.compact.join(" ")
  end

  # Generate HTML attributes hash (id, title, disabled, ARIA attributes, data attributes)
  # Returns hash for use with tag.attributes helper
  def html_attributes
    attrs = {}
    attrs[:id] = options[:id] if options[:id]
    attrs[:title] = options[:title] if options[:title]
    attrs[:disabled] = true if options[:disabled]
    
    # Merge ARIA attributes
    aria_attrs = aria_attributes
    aria_attrs.each { |k, v| attrs["aria-#{k}".to_sym] = v } if aria_attrs.any?
    
    # Merge data attributes
    if options[:data]
      options[:data].each { |k, v| attrs["data-#{k}".to_sym] = v }
    end
    
    attrs
  end

  # Generate ARIA attributes for accessibility (ensures aria-label for icon-only buttons)
  def aria_attributes
    attrs = {}
    if options[:aria]
      attrs.merge!(options[:aria])
    end
    # Ensure aria-label for icon-only buttons
    if icon_only? && attrs[:label].blank?
      attrs[:label] = text || options.dig(:aria, :label)
    end
    attrs
  end

  # Render icon SVG by loading from assets/images/icons/ directory
  # Rails.root.join - builds file path safely, works on any OS (handles / vs \)
  def render_icon
    # Load SVG from assets/images/icons/
    icon_path = Rails.root.join("app/assets/images/icons/#{icon}-icon.svg")
    
    if File.exist?(icon_path)
      # Load and inline SVG from file
      svg_content = File.read(icon_path)
      # Remove width/height attributes if present to allow scaling
      svg_content = svg_content.gsub(/\s(width|height)=["'][^"']*["']/, '')
      # Ensure SVG inherits size and color from parent
      svg_content = svg_content.gsub(/<svg/, '<svg style="width: 100%; height: 100%;" class="btn-icon-svg"')
      # .html_safe - tells Rails this HTML is safe to render (prevents auto-escaping)
      svg_content.html_safe
    else
      # Icon file not found
      nil
    end
  end
end

