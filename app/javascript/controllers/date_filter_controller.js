import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-filter"
export default class extends Controller {
  connect() {
  flatpickr(this.element, {
    mode: "range",
    })
}}
