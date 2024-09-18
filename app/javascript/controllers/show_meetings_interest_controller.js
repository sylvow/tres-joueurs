import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-meetings-interest"
export default class extends Controller {
  static targets = ["interested", "friends"]

  display() {
    if ( this.interestedTarget.innerText === "Je suis intéressé.e" ) {
      this.interestedTarget.innerText = "Je ne suis plus intéressé.e";
      this.interestedTarget.classList.remove("btn-primary");
      this.interestedTarget.classList.add("btn-secondary");
    } else {
      this.interestedTarget.innerText = "Je suis intéressé.e";
      this.interestedTarget.classList.add("btn-primary");
      this.interestedTarget.classList.remove("btn-secondary");
    }
    this.friendsTarget.classList.toggle("d-none")
  }
}
