import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "dialog"
  ]

  showModal() {
    this.dialogTarget.showModal()
  }

  closeModal() {
    this.dialogTarget.close()
  }
}
