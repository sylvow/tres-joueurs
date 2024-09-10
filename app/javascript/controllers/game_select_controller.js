import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {

  connect() {
    console.log("controller stimulus on")

    var config = {
      persist: false,
      createOnBlur: true,
      create: true
    };

    new TomSelect("#input-tags", config);
  }
}
