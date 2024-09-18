import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-filter"
export default class extends Controller {
  connect() {
    console.log("connected to date filter")
  flatpickr(this.element, {
    mode: "range",
    })
}}
