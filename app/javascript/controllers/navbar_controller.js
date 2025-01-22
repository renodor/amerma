import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  openMobileNav() {
    this.element.dataset.open = true
  }

  closeMobileNav() {
    this.element.dataset.open = false
  }
}
