import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {

  connect() {
    var config = {
      persist: false,
      createOnBlur: true,
      create: true
    };

    new TomSelect("#input-tags", config);

    new TomSelect("#filter-tags",{
      persist: false,
      createOnBlur: true,
      create: true
    });
  }
}
