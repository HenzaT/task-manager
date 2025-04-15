import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input"]
  timeout = null

  // search(event) {
  //   console.log("Typing detected")
  //   clearTimeout(this.timeout)

  //   this.timeout = setTimeout(() => {
  //     console.log("Submitting form...")
  //     this.element.requestSubmit()
  //   }, 300)
  }
// }
