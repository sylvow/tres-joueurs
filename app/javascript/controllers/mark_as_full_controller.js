import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  full(event) {
    const switchId = event.currentTarget.id
    const id = switchId.slice(7);
    
  }
}
