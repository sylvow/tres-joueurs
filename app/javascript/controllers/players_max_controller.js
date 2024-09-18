import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="players-max"
export default class extends Controller {
  static targets = ["field"]

  reveal() {
    this.fieldTarget.classList.toggle("d-none")
  }
}
