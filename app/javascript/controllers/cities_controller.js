import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="city-picker"
export default class extends Controller {
  static targets = ["aroundMeField", "cityInput", "results", "city", "fieldLat", "fieldLng", "fieldRadius", "toggler"]

  connect() {
    console.log("connected city-picker")
  }

  reveal() {
    console.log("toggle listened");
    this.cityInputTarget.classList.toggle("d-none")
    this.aroundMeFieldTarget.classList.toggle("d-none")
  }

  displayCities() {
    console.log("key up")
    console.log(this.cityInputTarget.value)
    const word = this.cityInputTarget.value
    const url = `https://geo.api.gouv.fr/communes?nom=${word}&fields=departement&boost=population&limit=5`
    fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      const results = data.map((city) => city.nom + ', ' + city.code)
      // const lng = data.map((city) => city.centre.coordinates[1])
      // console.log(lng)
      console.log(results)
      this.resultsTarget.innerHTML = ""
      results.forEach((suggestion) => {
        this.resultsTarget.insertAdjacentHTML('beforeend', `<li data-cities-target="city" data-action="click->cities#selectCity">${suggestion}</li>`);
      });
      // document.querySelector("#results").insertAdjacentHTML("afterbegin", liContent);
    });
  }

  selectCity(event) {
    console.log("click")
    console.log(event.target.innerText)
    this.cityInputTarget.value = event.target.innerText
    const city = event.target.innerText.split(",")[0]
    console.log(city);
    const url = `https://geo.api.gouv.fr/communes?nom=${city}&fields=departement,bbox&boost=population&limit=5`
    fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      const coordinates = data[0].bbox.coordinates[0][0]
      const lat = coordinates[1]
      const lng = coordinates[0]
      console.log(lat)
      console.log(lng);
      this.fieldLatTarget.value = lat
      this.fieldLngTarget.value = lng
    });
  }

}
