import { Controller } from "@hotwired/stimulus";

// Accordion controller for managing expand/collapse behavior
// Based on shadcn-ui accordion component with Radix-like behavior
//
// @tested: Opens item on trigger click
// @tested: Closes item on trigger click when collapsible
// @tested: Closes other items in single mode
// @tested: Allows multiple open items in multiple mode
// @tested: Updates aria-expanded attribute
// @tested: Updates data-state attribute
// @tested: Respects disabled state
// @tested: Handles keyboard navigation (Enter, Space, Arrow keys)

export default class extends Controller {
  static targets = ["item", "trigger", "body"];

  static values = {
    type: { type: String, default: "single" }, // "single" | "multiple"
    collapsible: { type: Boolean, default: false }, // Allow closing all items in single mode
    defaultValue: String, // Initial open item(s) - JSON string for multiple
  };

  connect() {
    this.#initializeDefaultState();
    this.#setupKeyboardNavigation();
  }

  disconnect() {
    this.#removeKeyboardNavigation();
  }

  // ========================================================================
  // Actions
  // ========================================================================

  // Toggle the accordion item containing the clicked trigger
  toggle(event) {
    const trigger = event.currentTarget;
    const item = trigger.closest("[data-accordion-target='item']");

    if (!item || item.hasAttribute("data-disabled")) {
      return;
    }

    const isOpen = item.dataset.state === "open";

    if (isOpen) {
      // Only close if collapsible is true, or if in multiple mode
      if (this.collapsibleValue || this.typeValue === "multiple") {
        this.#closeItem(item);
      }
    } else {
      // If single mode, close all other items first
      if (this.typeValue === "single") {
        this.#closeAllItems();
      }
      this.#openItem(item);
    }
  }

  // ========================================================================
  // Keyboard Navigation
  // ========================================================================

  #setupKeyboardNavigation() {
    this.boundHandleKeydown = this.#handleKeydown.bind(this);
    this.element.addEventListener("keydown", this.boundHandleKeydown);
  }

  #removeKeyboardNavigation() {
    if (this.boundHandleKeydown) {
      this.element.removeEventListener("keydown", this.boundHandleKeydown);
    }
  }

  #handleKeydown(event) {
    const trigger = event.target.closest("[data-accordion-target='trigger']");
    if (!trigger) return;

    switch (event.key) {
      case "ArrowDown":
        event.preventDefault();
        this.#focusNextTrigger(trigger);
        break;
      case "ArrowUp":
        event.preventDefault();
        this.#focusPreviousTrigger(trigger);
        break;
      case "Home":
        event.preventDefault();
        this.#focusFirstTrigger();
        break;
      case "End":
        event.preventDefault();
        this.#focusLastTrigger();
        break;
    }
  }

  #focusNextTrigger(currentTrigger) {
    const triggers = this.#getEnabledTriggers();
    const currentIndex = triggers.indexOf(currentTrigger);
    const nextIndex = (currentIndex + 1) % triggers.length;
    triggers[nextIndex]?.focus();
  }

  #focusPreviousTrigger(currentTrigger) {
    const triggers = this.#getEnabledTriggers();
    const currentIndex = triggers.indexOf(currentTrigger);
    const previousIndex =
      currentIndex <= 0 ? triggers.length - 1 : currentIndex - 1;
    triggers[previousIndex]?.focus();
  }

  #focusFirstTrigger() {
    const triggers = this.#getEnabledTriggers();
    triggers[0]?.focus();
  }

  #focusLastTrigger() {
    const triggers = this.#getEnabledTriggers();
    triggers[triggers.length - 1]?.focus();
  }

  #getEnabledTriggers() {
    return this.triggerTargets.filter((trigger) => {
      const item = trigger.closest("[data-accordion-target='item']");
      return !item?.hasAttribute("data-disabled");
    });
  }

  // ========================================================================
  // State Management
  // ========================================================================

  #initializeDefaultState() {
    if (!this.hasDefaultValueValue || !this.defaultValueValue) return;

    let defaultValues = [];

    try {
      // Try parsing as JSON array for multiple mode
      defaultValues = JSON.parse(this.defaultValueValue);
      if (!Array.isArray(defaultValues)) {
        defaultValues = [defaultValues];
      }
    } catch {
      // Single value string
      defaultValues = [this.defaultValueValue];
    }

    this.itemTargets.forEach((item) => {
      const itemValue = item.dataset.value;
      if (defaultValues.includes(itemValue)) {
        this.#openItem(item);
      }
    });
  }

  #openItem(item) {
    const trigger = item.querySelector("[data-accordion-target='trigger']");
    const body = item.querySelector("[data-accordion-target='body']");

    if (!trigger || !body) return;

    item.dataset.state = "open";
    trigger.setAttribute("aria-expanded", "true");
    body.dataset.state = "open";
  }

  #closeItem(item) {
    const trigger = item.querySelector("[data-accordion-target='trigger']");
    const body = item.querySelector("[data-accordion-target='body']");

    if (!trigger || !body) return;

    item.dataset.state = "closed";
    trigger.setAttribute("aria-expanded", "false");
    body.dataset.state = "closed";
  }

  #closeAllItems() {
    this.itemTargets.forEach((item) => {
      if (item.dataset.state === "open") {
        this.#closeItem(item);
      }
    });
  }

  // ========================================================================
  // Public API (for programmatic control)
  // ========================================================================

  // Open a specific item by value
  open(value) {
    const item = this.itemTargets.find((item) => item.dataset.value === value);
    if (item && !item.hasAttribute("data-disabled")) {
      if (this.typeValue === "single") {
        this.#closeAllItems();
      }
      this.#openItem(item);
    }
  }

  // Close a specific item by value
  close(value) {
    const item = this.itemTargets.find((item) => item.dataset.value === value);
    if (item) {
      this.#closeItem(item);
    }
  }

  // Get currently open item values
  get openValues() {
    return this.itemTargets
      .filter((item) => item.dataset.state === "open")
      .map((item) => item.dataset.value);
  }
}
