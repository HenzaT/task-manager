import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="card-toggle"
export default class extends Controller {

  static targets = [ "card" ]

  toggleColor() {
    this.cardTarget.classList.remove("in-progress");
  }
}
