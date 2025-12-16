module InputHelper
  # Generate ID from name attribute (converts "user[email]" to "user_email")
  def input_id_from_name(name)
    name.to_s.gsub(/\[|\]/, '_').gsub(/__/, '_').gsub(/_$/, '')
  end

  # Auto-detect autocomplete value based on type and name
  def auto_detect_autocomplete(type:, name:)
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

  # Render icon SVG by loading from app/assets/images/icons/ directory
  def render_input_icon(icon_name)
    icon_path = Rails.root.join("app/assets/images/icons/#{icon_name}-icon.svg")
    
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
end

