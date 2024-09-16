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
    // Supprime la classe active de toutes les dates
    Array.from(this.datesContainerTarget.children).forEach(date => {
      date.classList.remove("active")
    })

    // Ajoute la classe active à la date cliquée
    event.currentTarget.classList.add("active")
  }

  saveIndex() {
    // Sauvegarde l'index dans le localStorage
    localStorage.setItem('carouselIndex', this.index)
  }

  loadIndex() {
    // Récupère l'index depuis le localStorage
    return parseInt(localStorage.getItem('carouselIndex'))
  }

  get dates() {
    return this.datesContainerTarget.children
  }
}