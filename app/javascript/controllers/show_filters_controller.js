import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-filters"
export default class extends Controller {
  static targets = ["filtersButton", "showFilters"]

  display() {
    if ( this.filtersButtonTarget.innerText === "Filtrer les résultats +" ) {
      this.filtersButtonTarget.innerText = "Filtres -";
    } else {
      this.filtersButtonTarget.innerText = "Filtrer les résultats +";
    }
    this.showFiltersTarget.classList.toggle("d-none")
  }
}
