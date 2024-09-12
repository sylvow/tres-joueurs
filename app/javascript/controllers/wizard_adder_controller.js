import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wizard-adder"
export default class extends Controller {
  connect() {
    console.log("connected to wizard-adder");
    const simpleForm = document.querySelector("form")
    simpleForm.classList.add("wizard")
  }
}
