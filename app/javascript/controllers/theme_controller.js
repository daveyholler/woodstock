import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.applyTheme()
  }

  toggle() {
    const isDark = this.isDarkMode()
    const newTheme = isDark ? "light" : "dark"
    localStorage.setItem("theme", newTheme)
    this.applyTheme()
  }

  applyTheme() {
    const stored = localStorage.getItem("theme")
    const root = document.documentElement

    root.classList.remove("light", "dark")

    if (stored === "dark") {
      root.classList.add("dark")
    } else if (stored === "light") {
      root.classList.add("light")
    }
    // If no stored preference, let the CSS media query handle it
  }

  isDarkMode() {
    const stored = localStorage.getItem("theme")
    if (stored) {
      return stored === "dark"
    }
    // Fall back to system preference
    return window.matchMedia("(prefers-color-scheme: dark)").matches
  }
}
