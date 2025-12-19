# Step 2d: Generate Stimulus Controller (if needed)

Only generate if component has interactive behavior (dropdowns, modals, toggles, etc.)

## Decision Tree
Generate Stimulus controller if component:
- Manages open/closed state
- Handles keyboard interactions
- Has click-outside behavior
- Needs focus trapping
- Animates on state changes
- Responds to user interactions beyond basic clicks

## Controller Pattern
```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "content"]
  static values = {
    open: Boolean,
    closeOnClickOutside: { type: Boolean, default: true }
  }
  static classes = ["open", "closed"]

  connect() {
    // Setup event listeners
    // Initialize state
  }

  disconnect() {
    // Cleanup event listeners
    // Remove global listeners
  }

  // Actions
  toggle(event) {
    event.preventDefault()
    this.openValue = !this.openValue
  }

  open() {
    this.openValue = true
  }

  close() {
    this.openValue = false
  }

  // Event handlers
  handleClickOutside(event) {
    if (this.closeOnClickOutsideValue && !this.element.contains(event.target)) {
      this.close()
    }
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  // Value changed callbacks
  openValueChanged() {
    if (this.openValue) {
      this.#show()
    } else {
      this.#hide()
    }
  }

  // Private methods
  #show() {
    this.contentTarget.classList.add(...this.openClasses)
    this.contentTarget.classList.remove(...this.closedClasses)
    this.element.setAttribute("data-state", "open")
    this.#setupGlobalListeners()
  }

  #hide() {
    this.contentTarget.classList.remove(...this.openClasses)
    this.contentTarget.classList.add(...this.closedClasses)
    this.element.setAttribute("data-state", "closed")
    this.#removeGlobalListeners()
  }

  #setupGlobalListeners() {
    if (this.closeOnClickOutsideValue) {
      document.addEventListener("click", this.handleClickOutside.bind(this))
    }
    document.addEventListener("keydown", this.handleKeydown.bind(this))
  }

  #removeGlobalListeners() {
    document.removeEventListener("click", this.handleClickOutside.bind(this))
    document.removeEventListener("keydown", this.handleKeydown.bind(this))
  }
}
```

## Requirements
- Follow Stimulus best practices
- Use proper target, value, and class definitions
- Clean up event listeners in disconnect()
- Handle accessibility (keyboard navigation, ARIA updates)
- Mirror the behavior from the React component
- Use data-* attributes for state management

## Testing Considerations
Include comments for testable behaviors:
```javascript
// @tested: Opens on trigger click
// @tested: Closes on Escape key
// @tested: Closes on click outside
// @tested: Updates aria-expanded attribute
```

**IMPORTANT: You must create an actual file using the create_file tool.**

Save to: ./app/javascript/controllers/{component_name}_controller.js by calling:
```
create_file(path="./app/javascript/controllers/{component_name}_controller.js", content=<your Stimulus controller code>)
```

**Note:** Only generate this file if the component requires JavaScript interactivity. If the component is purely presentational, skip this step.
