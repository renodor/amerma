import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "imageInput",
    "imagePreview",
    "removeImageInput",
    "imageInvalidMessage"
  ]

  imageUploaded({ currentTarget }) {
    const files = currentTarget.files

    if (files.length > 0) {
      if (this.hasRemoveImageInputTarget) {
        this.removeImageInputTarget.disabled = true
      }
      this.element.dataset.hasImage = true
      this.imagePreviewTarget.src = URL.createObjectURL(files[0]);
      this.imageInvalidMessageTarget.dataset.show = !(this.imageInputTarget.accept.split(",").includes(files[0].type))
    }
  }

  removeImage() {
    this.element.dataset.hasImage = false
    this.removeImageInputTarget.disabled = false
    this.imageInputTarget.value = ""
  }
}