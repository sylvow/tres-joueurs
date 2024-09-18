import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="steps"
export default class extends Controller {
  static targets = [ "gameInfo", "meetingInfo", "titleAndDesc" ]

  goToMeetingInfo() {
    this.meetingInfoTarget.classList.remove("d-none");
    this.gameInfoTarget.classList.add("d-none");
    this.titleAndDescTarget.classList.add("d-none");

  }

  goToGameInfo() {
    this.meetingInfoTarget.classList.add("d-none");
    this.titleAndDescTarget.classList.add("d-none");
    this.gameInfoTarget.classList.remove("d-none");
  }

  goToTitleAndDesc() {
    this.gameInfoTarget.classList.add("d-none");
    this.meetingInfoTarget.classList.add("d-none");
    this.titleAndDescTarget.classList.remove("d-none");
  }
}
