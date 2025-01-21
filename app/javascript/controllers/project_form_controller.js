import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "coverPhotoContainer",
    "imageInput",
    "imagePreview",
    "removeCoverPhotoInput"
  ]

  imageUploaded({ currentTarget}) {
    const files = currentTarget.files
    const imagePreview = this.imagePreviewTargets.find((imagePreview) => imagePreview.dataset.id == currentTarget.dataset.id)

    if (imagePreview && files.length > 0) {
      this.removeCoverPhotoInputTarget.disabled = true
      this.coverPhotoContainerTarget.dataset.hasCoverPhoto = true
      imagePreview.src = URL.createObjectURL(files[0]);
    }
  }

  removeImage() {
    this.coverPhotoContainerTarget.dataset.hasCoverPhoto = false
    this.removeCoverPhotoInputTarget.disabled = false
    this.imageInputTarget.value = ""
  }
}
