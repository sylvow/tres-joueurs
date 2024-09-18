// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = ["datesContainer"]

//   connect() {
//     this.visibleDates = 7
//     this.index = this.loadIndex() || 0
//     this.updateVisibleDates()
//   }

//   next() {
//     if (this.index + this.visibleDates < this.dates.length) {
//       this.index++
//       this.saveIndex()
//       this.updateVisibleDates()
//     }
//   }

//   previous() {
//     if (this.index > 0) {
//       this.index--
//       this.saveIndex()
//       this.updateVisibleDates()
//     }
//   }

//   updateVisibleDates() {
//     const allDates = Array.from(this.datesContainerTarget.children)
//     allDates.forEach((date, i) => {
//       date.style.display = (i >= this.index && i < this.index + this.visibleDates) ? "inline-block" : "none"
//     })
//   }

//   selectDate(event) {
//     const clickedDate = event.currentTarget

//     if (clickedDate.classList.contains("bg-success")) {
//       this.redirectToIndex()
//     }
//   }
//   redirectToIndex() {
//     window.location.href = "/meetings"
//   }

//   saveIndex() {
//     localStorage.setItem('carouselIndex', this.index)
//   }

//   loadIndex() {
//     return parseInt(localStorage.getItem('carouselIndex'))
//   }

//   get dates() {
//     return this.datesContainerTarget.children
//   }
// }