# Checkbox Component

This document outlines the implementation plan for the Checkbox component.

## 1. Architecture

The Checkbox component will follow the project's existing UI component pattern:
- **Partial**: `app/views/shared/_checkbox.html.erb`
- **Stylesheets**: 
  - `app/assets/stylesheets/components/checkbox.css`
  - `app/assets/stylesheets/components/checkbox/checkbox_base.css`
  - `app/assets/stylesheets/components/checkbox/checkbox_tokens.css`
  - `app/assets/stylesheets/components/checkbox/checkbox_sizes.css`
- **UI Kit**: `app/views/ui_kit/pages/checkboxes.html.erb`

## 2. Implementation Stages

### Stage 1: Basic Structure & Styling (Foundation)
- Create CSS tokens for checkboxes (colors, dimensions).
- Implement base styles for the checkbox input (hidden) and its custom representation.
- Create the `_checkbox` shared partial.
- Add a basic "Checkboxes" page to the UI Kit.

### Stage 2: States & Sizes
- Implement styling for different states: `:hover`, `:active`, `:focus`, `:disabled`, `:checked`.
- Implement size variants (Small, Medium, Large).
- Add variants to the UI Kit page.

### Stage 3: Labels & Errors
- Support label positioning (left/right).
- Support error states and messaging.
- Refine accessibility (ARIA attributes, keyboard interaction).

### Stage 4: Advanced Features (Optional)
- Support indeterminate state.
- Support checkbox groups.

## 3. Usage Example

```erb
<%= render "shared/checkbox",
  label: "Remember me",
  name: "remember_me",
  checked: true
%>
```

