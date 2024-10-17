import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="city-search"
export default class extends Controller {
  static targets = ["input", "suggestions"]

  tester() {
    console.log("Typing taken into account")
    fetch('./cities.json')
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok ' + response.statusText);
      }
      return response.json();
    })
    .then(data => {
      const cities = data['cities'];
      // console.log(cities);
      const query = this.inputTarget.value.toLowerCase()
      // console.log(query)
      const filteredCities = cities.filter(city =>
          city.city_code.toLowerCase().includes(query)
        )
        // console.log("Filtered Cities:", filteredCities)
        // this.displaySuggestions(filteredCities)
    })
    .catch(error => {
      console.error('Error fetching or parsing cities:', error);
    });

  }



  initialize() {
    this.cities = []
    this.fetchCities()
  }

  async fetchCities() {
    const response = await fetch('/cities.json')
    this.cities = await response.json()
  }

  connect() {
    this.inputTarget.addEventListener('input', this.search.bind(this))
  }

  search() {
    const query = this.inputTarget.value.toLowerCase()
    this.suggestionsTarget.innerHTML = ''
    if (query.length > 0) {
      const filteredCities = this.cities.filter(city =>
        city.city.toLowerCase().includes(query)
      )
      this.displaySuggestions(filteredCities)
    }
  }

  displaySuggestions(cities) {
    if (cities.length > 0) {
      this.suggestionsTarget.style.display = 'block'
      cities.forEach(city => {
        const li = document.createElement('li')
        li.textContent = `${city.city} (${city.postcode})`
        li.dataset.coordinates = JSON.stringify(city.coordinates)
        li.addEventListener('click', () => this.selectCity(city))
        this.suggestionsTarget.appendChild(li)
      })
    } else {
      this.suggestionsTarget.style.display = 'none'
    }
  }

  selectCity(city) {
    this.inputTarget.value = city.city
    this.suggestionsTarget.style.display = 'none'
    // You can handle the coordinates here
    console.log(city.coordinates)
  }
}
