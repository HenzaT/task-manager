import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="banner"
export default class extends Controller {

  static targets = ["banner"]

  connect() {}
}
