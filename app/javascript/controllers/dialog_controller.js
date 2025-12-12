import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  connect() {
    // Store reference to the dialog element
    this.dialogElement = this.dialogTarget
    // Store element that had focus before opening (for restoration)
    this.previousActiveElement = null
  }

  // Open dialog
  open(event) {
    event.preventDefault()
    this.previousActiveElement = document.activeElement
    this.dialogElement.showModal()
  }

  // Close dialog
  close(event) {
    event.preventDefault()
    this.dialogElement.close()
    // Restore focus to previous element
    if (this.previousActiveElement) {
      this.previousActiveElement.focus()
      this.previousActiveElement = null
    }
  }

  // Handle backdrop click (close dialog when clicking outside)
  handleBackdropClick(event) {
    // Check if click was on the backdrop (not on dialog content)
    if (event.target === this.dialogElement) {
      this.close(event)
    }
  }
}

