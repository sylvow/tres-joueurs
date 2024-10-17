import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

// Connects to data-controller="poi-autocomplete"
export default class extends Controller {
  static targets = ["searchBox", "name", "address", "divToDisplay", "latitude", "longitude"]
  static values = { apiKey: String }

  connect() {
    const searchBox = this.searchBoxTarget
    mapboxgl.accessToken = this.apiKeyValue
    searchBox.options = {
      language: 'fr',
      country: 'FR'
    }

    const search = new MapboxSearchBox()
    search.accessToken = this.apiKeyValue
    searchBox.appendChild(search)

    search.addEventListener("retrieve", (event) => {
      const featureCollection = event.detail
      const placeName = featureCollection["features"][0]["properties"]["name"]
      const placeAddress = featureCollection["features"][0]["properties"]["full_address"]
      const placeLatitude = featureCollection["features"][0]["geometry"]["coordinates"][1]
      const placeLongitude = featureCollection["features"][0]["geometry"]["coordinates"][0]
      this.nameTarget.value = placeName
      this.addressTarget.value = placeAddress
      this.latitudeTarget.value = placeLatitude
      this.longitudeTarget.value = placeLongitude
      this.divToDisplayTarget.classList.remove("d-none")
    })
  }


  // setupSuggestionClickListener() {
  //   document.querySelector("mapbox-search-listbox").addEventListener("retrieve", (event) => {
  //     console.log(event.target)
  //     console.log(event.detail)

    // document.addEventListener("click", (event) => {
    //   console.log(event.target)

    //   const suggestionName = document.querySelector('*[class*="SuggestionName"]').textContent
    //   const suggestionAddress = document.querySelector('*[class*="SuggestionDesc"]').textContent

    //   // console.log("Name:", suggestionName)
    //   // console.log("Address:", suggestionAddress)

    //   this.clickedSuggestionName = suggestionName
    //   this.clickedSuggestionAddress = suggestionAddress
    // })

    // document.addEventListener("click", (event) => {
    //   console.log(event.target)
    //     const suggestionNameElement = event.target.querySelector('*[class*="SuggestionName"]')
    //     const suggestionAddressElement = event.target.querySelector('*[class*="SuggestionDesc"]')

    //     if (suggestionNameElement && suggestionAddressElement) {
    //       const suggestionName = suggestionNameElement.textContent.trim()
    //       const suggestionAddress = suggestionAddressElement.textContent.trim()

    //       // console.log("Name:", suggestionName)
    //       // console.log("Address:", suggestionAddress)

    //       this.clickedSuggestionName = suggestionName
    //       this.clickedSuggestionAddress = suggestionAddress
    //     } else {
    //       console.log("pas trouvé de name et adrress")
    //     }
  //   });
  // }


}
