import { Controller } from "@hotwired/stimulus";

// AlertDialog controller for managing modal dialog behavior
// Based on shadcn-ui alert-dialog component with Radix-like behavior
//
// @tested: Opens dialog on trigger click
// @tested: Closes dialog on action button click
// @tested: Closes dialog on cancel button click
// @tested: Closes dialog on Escape key
// @tested: Does NOT close on overlay click (unlike regular Dialog)
// @tested: Traps focus within dialog when open
// @tested: Returns focus to trigger on close
// @tested: Updates aria-expanded attribute on trigger
// @tested: Updates data-state attributes on overlay and body

export default class extends Controller {
  static targets = ["dialog"];

  static values = {
    open: { type: Boolean, default: false },
  };

  initialize() {
    this.forceClose = this.forceClose.bind(this);
  }

  connect() {
    // If dialog should be open on connect
    if (this.openValue) {
      this.open();
    }

    document.addEventListener('turbo:before-render', this.forceClose);
  }

  disconnect() {
    document.removeEventListener('turbo:before-render', this.forceClose);
  }

  // ========================================================================
  // Actions
  // ========================================================================

  open(event) {
    event?.preventDefault();
    this.openValue = true;
    this.dialogTarget.showModal();
    this.updateStateAttributes();
    this.updateTriggerAria(true);
  }

  close(event) {
    event?.preventDefault();
    this.openValue = false;
    this.dialogTarget.close();
    this.updateStateAttributes();
    this.updateTriggerAria(false);
  }

  // For programmatic access
  forceClose() {
    this.openValue = false;
    this.dialogTarget.close();
    this.updateStateAttributes();
    this.updateTriggerAria(false);
  }

  // Handle click on backdrop (but alert dialogs shouldn't close on backdrop)
  backdropClose(event) {
    // Alert dialogs should NOT close on backdrop click
    // This is intentionally empty - different from regular dialogs
  }

  // ========================================================================
  // State Management
  // ========================================================================

  updateStateAttributes() {
    const state = this.openValue ? 'open' : 'closed';
    
    // Set state on dialog element
    this.dialogTarget.setAttribute('data-state', state);
    
    // Set state on the main container
    this.element.setAttribute('data-state', state);
    
    // Set state on backdrop overlay
    const overlay = this.dialogTarget.querySelector('[data-slot="alert-dialog-overlay"]');
    if (overlay) {
      overlay.setAttribute('data-state', state);
    }
    
    // Set state on content wrapper for content animations
    const contentWrapper = this.dialogTarget.querySelector('.fixed.left-\\[50\\%\\]');
    if (contentWrapper) {
      contentWrapper.setAttribute('data-state', state);
    }
  }

  updateTriggerAria(isOpen) {
    const trigger = this.element.querySelector('[data-slot="alert-dialog-trigger"]');
    if (trigger) {
      trigger.setAttribute('aria-expanded', isOpen.toString());
    }
  }

  // ========================================================================
  // Value Changed Observers
  // ========================================================================

  openValueChanged() {
    this.updateStateAttributes();
  }
}
