import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["notificationsDropdown"]

  connect() {
  }

  clearRequestBadge(event) {
    const badge = this.element.querySelector(".badge.bg-danger")
    if (badge) {
      badge.remove()
    }
  }
}
