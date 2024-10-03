import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {

  connect() {
    var config = {
      create: true,
      sortField: {
        field: "text",
        direction: "asc"
      },
      persist: false,
      createOnBlur: true
    };

    new TomSelect("#input-tags", config);

    new TomSelect("#filter-tags",{
      persist: false,
      createOnBlur: true,
      create: true
    });
  }
}
