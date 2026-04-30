import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  showMore() {
    this.element.dataset.showMore = true
  }

  showLess() {
    this.element.dataset.showMore = false
  }
}
