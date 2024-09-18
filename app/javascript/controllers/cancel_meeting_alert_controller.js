import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'
// Connects to data-controller="cancel-meeting-alert"
export default class extends Controller {
  alert(event) {
    event.preventDefault()
    const id = event.target.id.slice(8);
    const url = `/meetings/${id}/cancel`
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    const init = { 
      method: "PATCH",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
     }
    Swal.fire({
      title: "Supprimer?",
      text: "Es-tu certain de vouloir annuler cette rencontre?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Oui, annuler!",
      cancelButtonText: "Non, retour"
    }).then((result) => {
      if (result.isConfirmed) {
        fetch(url, init)
          .then(response => response.json())
          .then(data => {
            Swal.fire({
              title: data.title,
              text: data.message,
              icon: "success"
            }).then( result => {
              if (result.isConfirmed) {
                window.location.reload();
                }
              });
          });
      }
    });
  }
}
