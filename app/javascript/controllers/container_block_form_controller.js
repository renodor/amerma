import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "classListInput",
    "containerPreview"
  ]

  updateClassList({ currentTarget }) {
    if (!currentTarget.checked) {
      currentTarget.checked = true
      return
    }

    this.containerPreviewTarget.className = "grid grid-cols-auto"

    this.classListInputTargets.forEach((input) => {
      if (input.dataset.type === currentTarget.dataset.type) {
        input.checked = input.value == currentTarget.value
      }

      if (input.checked) {
        this.containerPreviewTarget.classList.add(input.value)
      }
    })
  }
}
