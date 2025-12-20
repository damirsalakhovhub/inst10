import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleClick(event) {
    const button = event.currentTarget
    
    // Prevent multiple clicks while loading
    if (button.classList.contains('btn-loading')) {
      event.preventDefault()
      return
    }
    
    event.preventDefault()
    
    // Toggle loading class - CSS handles everything
    button.classList.add('btn-loading')
    
    // Auto-reset after 2 seconds
    setTimeout(() => {
      button.classList.remove('btn-loading')
    }, 1000)
  }

  connect() {
    this.element.querySelectorAll('.btn-loading-demo').forEach(button => {
      button.addEventListener('click', this.handleClick.bind(this))
    })
  }
}

