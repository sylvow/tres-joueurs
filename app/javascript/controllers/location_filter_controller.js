import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location-filter"
export default class extends Controller {
  static targets = ["field", "radius", "fieldLat", "fieldLng", "fieldRadius"]

  connect() {
    console.log("location-filter stimulus on");
  }

  activateGeo() {

    console.log("activateGeoClicked")
    const radius = this.radiusTarget.value
    console.log(radius);
    console.log(this.fieldLatTarget)
    console.log(this.fieldLngTarget)
    let lat = 0;
    let lng = 0;
    const url = new URL(window.location.href);
    // if (navigator.geolocation) {
    // if ((!url.searchParams.has("lat") || !url.searchParams.has("lng"))){
      navigator.geolocation.getCurrentPosition(
        (data)=> {
          lat = data.coords.latitude;
          lng = data.coords.longitude;
          // // url.searchParams.set("lat", lat);
          // // url.searchParams.set("lng", lng);
          // url.searchParams.set("radius", radius);
          // window.location.href = url;
          console.log(lat)
          console.log(lng)
          this.fieldLatTarget.value = lat
          this.fieldLngTarget.value = lng
        });
    this.fieldTarget.value = `Autour de moi - ${radius} km`
    this.fieldRadiusTarget.value = radius
  }

}
