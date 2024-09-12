import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="players-max"
export default class extends Controller {
  static targets = ["field"]

  connect() {
    console.log("players max controller on");
  }

  reveal() {
    console.log("toggle listened");
    this.fieldTarget.classList.toggle("d-none")
  }
}
