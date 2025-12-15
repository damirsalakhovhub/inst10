module ButtonHelper
  # Simple button helper (37signals style)
  # Usage: button_tag "Click", class: "btn btn-primary"
  # Or: link_to "Click", path, class: "btn btn-primary"
  
  def button_classes(variant: :primary, size: :medium, **options)
    classes = ["btn"]
    classes << "btn-#{variant}" unless variant == :primary
    classes << "btn-#{size}" unless size == :medium
    classes << options[:class] if options[:class]
    classes.compact.join(" ")
  end
end

