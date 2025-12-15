module DialogHelper
  def dialog_tag(id: nil, open: false, **options, &block)
    dialog_id = id || "dialog-#{SecureRandom.hex(4)}"
    attrs = {
      id: dialog_id,
      role: "dialog",
      "aria-modal": "true",
      "aria-labelledby": "#{dialog_id}-title",
      "data-dialog-target": "dialog",
      "data-action": "click->dialog#handleBackdropClick"
    }
    attrs[:open] = true if open
    
    # Merge additional data attributes
    if options[:data]
      options[:data].each { |k, v| attrs["data-#{k}".to_sym] = v }
    end
    
    content_tag(:dialog, attrs, &block)
  end

  def dialog_title_id(dialog_id)
    "#{dialog_id}-title"
  end
end

