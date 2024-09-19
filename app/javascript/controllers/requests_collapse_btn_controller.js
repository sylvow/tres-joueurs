import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="requests-collapse-btn"
export default class extends Controller {
  static targets = [ "content" ]

  // Connects to data-action="click->requests-collapse-btn#toggle"
  toggle(event) {
    
  }
}
