import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location-filter"
export default class extends Controller {
  static targets = ["aroundMeField", "radius", "fieldLat", "fieldLng", "fieldRadius", "toggler", "cityInput", "results", "city"]

  connect() {
    const radius = this.radiusTarget.value
    this.fieldRadiusTarget.value = radius
  }

  updateRadius() {
    const radius = this.radiusTarget.value
    this.fieldRadiusTarget.value = radius
  }

  revealField() {
    this.resultsTarget.value = ""
    this.cityInputTarget.value =""
    this.aroundMeFieldTarget.value =""
    this.fieldLatTarget.value = ""
    this.fieldLngTarget.value = ""
    this.cityInputTarget.classList.toggle("d-none")
    this.aroundMeFieldTarget.classList.toggle("d-none")
    if ( this.togglerTarget.checked === true ) {
      this.activateGeo();
    }
    else {
      displayCities()
    }
  }

  activateGeo() {
    const radius = this.radiusTarget.value
    this.fieldRadiusTarget.value = radius
    // let lat = 0;
    // let lng = 0;
    // const url = new URL(window.location.href);
    // if (navigator.geolocation) {
    // if ((!url.searchParams.has("lat") || !url.searchParams.has("lng"))){
      navigator.geolocation.getCurrentPosition(
        (data)=> {
          const lat = data.coords.latitude;
          const lng = data.coords.longitude;
          // // url.searchParams.set("lat", lat);
          // // url.searchParams.set("lng", lng);
          // url.searchParams.set("radius", radius);
          // window.location.href = url;
          this.fieldLatTarget.value = lat
          this.fieldLngTarget.value = lng
        });
    this.aroundMeFieldTarget.value = `Autour de moi - ${radius} km`

  }

  displayCities() {
    const word = this.cityInputTarget.value.toLowerCase()
    // const url = `https://geo.api.gouv.fr/communes?nom=${word}&fields=departement&boost=population&limit=5`
    fetch('./cities.json')
    .then(response => response.json())
    .then(data => {
      const cities = data['cities'];
      console.log(cities);
      // const word = this.cityInputTarget.value.toLowerCase()
      console.log(word)
      const filteredCities = cities.filter(city =>
          city.city_code.toLowerCase().includes(word)
        )
        console.log("Filtered Cities:", filteredCities)
        // this.displaySuggestions(filteredCities)
      const results = filteredCities.map((city) => city.city_code.toUpperCase() + ', ' + city.zip_code)
      this.resultsTarget.innerHTML = ""
      results.forEach((suggestion) => {
        this.resultsTarget.insertAdjacentHTML('beforeend', `<li data-location-filter-target="city" data-action="click->location-filter#selectCity">${suggestion}</li>`);
      });
    })
  }

  selectCity(event) {
    this.cityInputTarget.value = event.target.innerText
    const city_name = event.target.innerText.split(", ")[0]
    // const url = `https://geo.api.gouv.fr/communes?code=${cityCode}&fields=code,nom,centre`
    fetch('./cities.json')
    .then(response => response.json())
    .then((data) => {
      const cities = data['cities'];
      const selectedCity = cities.filter(city =>
        city.city_code.toLowerCase() === city_name.toLowerCase()
      )
      console.log(selectedCity);
      const lat = selectedCity[0]['latitude']
      const lng = selectedCity[0]['longitude']
      this.fieldLatTarget.value = lat
      this.fieldLngTarget.value = lng
    });
  }

}
