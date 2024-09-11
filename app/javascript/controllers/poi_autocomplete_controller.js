import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

// Connects to data-controller="poi-autocomplete"
export default class extends Controller {
  static targets = ["poi", "searchBox"]
  static values = { apiKey: String }

  connect() {
    console.log("connected")
    const searchBox = this.searchBoxTarget
    console.log(searchBox)
    mapboxgl.accessToken = this.apiKeyValue
    const search = new MapboxSearchBox()
    search.accessToken = this.apiKeyValue
    searchBox.appendChild(search)
    console.log(search.result)

  }
  setInputValue() {
      // this.addressTarget.value = event.result["place_name"]

  }

}
