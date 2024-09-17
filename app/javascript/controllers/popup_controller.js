import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popup"
export default class extends Controller {

  alreadyRequested(event) {
    console.log("already requested")
    event.preventDefault();



    // url = "/requests/create";

    // fetch(url, {
    //   method: "POST",
    //   headers: {
    //     "Content-Type": "application/json",
    //     "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
    //   }
    // }).then(res => {res.json()})
    //   .then(data => console.log(data))








  }
}
