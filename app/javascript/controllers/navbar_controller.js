import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleMobileNav() {
    this.element.dataset.open = !(this.element.dataset.open === "true")
  }
}
