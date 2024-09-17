import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["datesContainer"]

  connect() {
    this.visibleDates = 7 // Nombre de dates visibles à la fois
    this.index = this.loadIndex() || 0 // Charger l'index du carrousel depuis le localStorage
    this.updateVisibleDates()
  }

  next() {
    if (this.index + this.visibleDates < this.dates.length) {
      this.index++
      this.saveIndex()
      this.updateVisibleDates()
    }
  }

  previous() {
    if (this.index > 0) {
      this.index--
      this.saveIndex()
      this.updateVisibleDates()
    }
  }

  updateVisibleDates() {
    const allDates = Array.from(this.datesContainerTarget.children)
    allDates.forEach((date, i) => {
      date.style.display = (i >= this.index && i < this.index + this.visibleDates) ? "inline-block" : "none"
    })
  }

  selectDate(event) {
    Array.from(this.datesContainerTarget.children).forEach(date => {
      date.classList.remove("active")
    })

    event.currentTarget.classList.add("active")
  }

  saveIndex() {
    localStorage.setItem('carouselIndex', this.index)
  }

  loadIndex() {
    return parseInt(localStorage.getItem('carouselIndex'))
  }

  get dates() {
    return this.datesContainerTarget.children
  }
}