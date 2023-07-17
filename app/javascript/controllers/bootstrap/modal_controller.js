import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bootstrap--modal"
export default class extends Controller {
  static values = {
    modalId: String
  }

  pop(){
    const locationModal = new bootstrap.Modal(this.modalIdValue);
    locationModal.show();    
  }
}
