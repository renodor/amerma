import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "imageInput",
    "imagePreview",
    "removeCoverPhotoInput"
  ]

  imageUploaded({ currentTarget }) {
    const files = currentTarget.files

    console.log(currentTarget)
    if (files.length > 0) {
      this.removeCoverPhotoInputTarget.disabled = true
      this.element.dataset.hasImage = true
      this.imagePreviewTarget.src = URL.createObjectURL(files[0]);
    }
  }

  removeImage() {
    this.element.dataset.hasImage = false
    this.removeCoverPhotoInputTarget.disabled = false
    this.imageInputTarget.value = ""
  }
}