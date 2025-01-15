import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "coverPhotoContainer",
    "imageInput",
    "imagePreview",
    "removeCoverPhotoInput",
    "newContainerModal",
    "containerBlockClassListInput",
    "containerPreview"
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

  removeImage({ currentTarget }) {
    const imageInput = this.imageInputTargets.find((imagePreview) => imagePreview.dataset.id == currentTarget.dataset.id)

    if (imageInput) {
      this.coverPhotoContainerTarget.dataset.hasCoverPhoto = false
      this.removeCoverPhotoInputTarget.disabled = false
      imageInput.value = ""
    }
  }

  showNewContainerModal() {
    this.newContainerModalTarget.showModal()
  }

  updateContainerBlockClassList({ currentTarget }) {
    this.containerBlockClassListInputTargets.forEach((input) => {
      if (input.dataset.type == currentTarget.dataset.type) {
        input.disabled = input.dataset.value !== currentTarget.dataset.value
      }
    })

    this.containerPreviewTarget.dataset[currentTarget.dataset.type] = currentTarget.dataset.value
  }

//   const dialog = document.querySelector("dialog");
// const showButton = document.querySelector("dialog + button");
// const closeButton = document.querySelector("dialog button");

// // "Show the dialog" button opens the dialog modally
// showButton.addEventListener("click", () => {
//   dialog.showModal();
// });

// // "Close" button closes the dialog
// closeButton.addEventListener("click", () => {
//   dialog.close();
// });
}
