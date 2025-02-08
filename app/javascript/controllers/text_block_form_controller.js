import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "richTextEditor",
    "rawTextInput"
  ]

  isRawHtmlChanged({ currentTarget }) {
    this.richTextEditorTargets.forEach((editor) => editor.disabled = currentTarget.checked)
    this.rawTextInputTargets.forEach((input) => input.disabled = !currentTarget.checked)
  }
}
