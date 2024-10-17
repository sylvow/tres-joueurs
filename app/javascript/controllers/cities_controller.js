import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="city-picker"
export default class extends Controller {
  static targets = ["aroundMeField", "cityInput", "results", "city", "fieldLat", "fieldLng", "fieldRadius", "toggler"]

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

  // displayCities() {
  //   const word = this.cityInputTarget.value
  //   const url = `https://geo.api.gouv.fr/communes?nom=${word}&fields=departement&boost=population&limit=5`
  //   fetch(url)
  //   .then(response => response.json())
  //   .then((data) => {
  //     const results = data.map((city) => city.nom + ', ' + city.code)
  //     // const lng = data.map((city) => city.centre.coordinates[1])
  //     // console.log(lng)
  //     console.log(results)
  //     this.resultsTarget.innerHTML = ""
  //     results.forEach((suggestion) => {
  //       this.resultsTarget.insertAdjacentHTML('beforeend', `<li data-cities-target="city" data-action="click->cities#selectCity">${suggestion}</li>`);
  //     });
  //     // document.querySelector("#results").insertAdjacentHTML("afterbegin", liContent);
  //   });
  // }

  selectCity(event) {
    this.cityInputTarget.value = event.target.innerText
    const city = event.target.innerText.split(",")[0]
    const url = `https://geo.api.gouv.fr/communes?nom=${city}&fields=departement,bbox&boost=population&limit=5`
    fetch(url)
    .then(response => response.json())
    .then((data) => {
      const coordinates = data[0].bbox.coordinates[0][0]
      const lat = coordinates[1]
      const lng = coordinates[0]
      this.fieldLatTarget.value = lat
      this.fieldLngTarget.value = lng
    });
  }

}
