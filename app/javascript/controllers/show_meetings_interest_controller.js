import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-meetings-interest"
export default class extends Controller {
  static targets = ["interested", "friends"]

  connect() {
  }

  display() {
    
    if ( this.interestedTarget.innerText === "Je suis intéressé.e" ) {
      this.interestedTarget.innerText = "Je ne suis plus intéressé.e";
    } else {
      this.interestedTarget.innerText = "Je suis intéressé.e";
    }
    this.friendsTarget.classList.toggle("d-none")
  }
}