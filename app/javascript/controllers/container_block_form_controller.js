import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "classListInput",
    "containerPreview",
    "columnDeleteWarning"
  ]

  static values = {
    persistedColumnCount: Number
  }

  updateClassList({ currentTarget }) {
    if (!currentTarget.checked) {
      currentTarget.checked = true
      return
    }

    this.containerPreviewTarget.className = "grid grid-cols-auto gap-6 p-4"

    this.classListInputTargets.forEach((input) => {
      if (input.dataset.type === currentTarget.dataset.type) {
        input.checked = input.value == currentTarget.value
      }

      if (input.checked) {
        this.containerPreviewTarget.classList.add(input.value)
      }
    })
  }

  updateColumnCount({ currentTarget }) {
    this.element.dataset.columnCount = currentTarget.value

    if (this.element.dataset.persisted === "true" && currentTarget.value < this.persistedColumnCountValue) {
      this.columnDeleteWarningTarget.dataset.show = true
    } else {
      this.columnDeleteWarningTarget.dataset.show = false
    }
  }
}
