import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.beforeStreamRender = this.beforeStreamRender.bind(this)
    document.addEventListener(
      "turbo:before-stream-render",
      this.beforeStreamRender
    )
  }

  disconnect() {
    document.removeEventListener(
      "turbo:before-stream-render",
      this.beforeStreamRender
    )
  }

  beforeStreamRender(event) {
    if (event.target.action !== "remove") return

    if (!document.startViewTransition) return

    const originalRender = event.detail.render

    event.detail.render = (streamElement) => {
      document.startViewTransition(() => {
        originalRender(streamElement)
      })
    }
  }
}
