import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location-filter"
export default class extends Controller {
  static targets = ["aroundMeField", "radius", "fieldLat", "fieldLng", "fieldRadius", "toggler", "cityInput", "results", "city"]

  connect() {
    console.log("location-filter stimulus on");
  }

  revealField() {
    console.log("toggle listened")
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
          console.log(lat)
          console.log(lng)
        });
    this.aroundMeFieldTarget.value = `Autour de moi - ${radius} km`
    this.fieldRadiusTarget.value = radius
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
        this.resultsTarget.insertAdjacentHTML('beforeend', `<li data-location-filter-target="city" data-action="click->location-filter#selectCity">${suggestion}</li>`);
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
