import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datetime-selector"
export default class extends Controller {
  connect() {
    const today = new Date();
    flatpickr(this.element, {
      minDate: today,
      enableTime: true,
      minuteIncrement: 30,
      dateFormat: "Y-m-d H:i",
      time_24hr: true,
      locale: {
        firstDayOfWeek: 1
      }
    })
}}
