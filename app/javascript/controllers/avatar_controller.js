import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "fallback"]

  connect() {
    this.showImage()
  }

  load() {
    this.showImage()
  }

  error() {
    this.showFallback()
  }

  showImage() {
    if (this.hasImageTarget && this.hasFallbackTarget) {
      this.imageTarget.classList.remove("hidden")
      this.fallbackTarget.classList.add("hidden")
    }
  }

  showFallback() {
    if (this.hasImageTarget && this.hasFallbackTarget) {
      this.imageTarget.classList.add("hidden")
      this.fallbackTarget.classList.remove("hidden")
    }
  }
}
