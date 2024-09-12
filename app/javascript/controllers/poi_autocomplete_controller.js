import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

// Connects to data-controller="poi-autocomplete"
export default class extends Controller {
  static targets = ["searchBox", "name", "address"]
  static values = { apiKey: String }

  connect() {
    const searchBox = this.searchBoxTarget
    mapboxgl.accessToken = this.apiKeyValue

    const search = new MapboxSearchBox()
    search.accessToken = this.apiKeyValue
    searchBox.appendChild(search)

    search.addEventListener("retrieve", (event) => {
      const featureCollection = event.detail
      console.log("Name:", featureCollection["features"][0]["properties"]["name"])
      console.log("Address:", featureCollection["features"][0]["properties"]["full_address"])
      const placeName = featureCollection["features"][0]["properties"]["name"]
      const placeAddress = featureCollection["features"][0]["properties"]["full_address"]
      this.nameTarget.value = placeName
      this.addressTarget.value = placeAddress
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
