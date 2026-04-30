import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "icon",
    "selectableIcon",
    "iconInput"
  ]

  changeIcon({params: { index }}) {
    const svg = this.selectableIconTargets[index]
    this.iconTarget.innerHTML = svg.innerHTML
    this.iconInputTarget.value = svg.dataset.icon
  }
}
