# frozen_string_literal: true

require "rails_helper"

RSpec.describe ButtonComponent, type: :component do
  # ==========================================================================
  # Rendering Tests
  # ==========================================================================

  describe "rendering" do
    it "renders a button element by default" do
      render_inline(described_class.new) { "Click me" }

      expect(page).to have_css("button")
    end

    it "renders the content passed in the block" do
      render_inline(described_class.new) { "Submit Form" }

      expect(page).to have_button("Submit Form")
    end

    it "renders with base Tailwind classes" do
      render_inline(described_class.new) { "Button" }

      expect(page).to have_css("button.inline-flex")
      expect(page).to have_css("button.items-center")
      expect(page).to have_css("button.justify-center")
    end

    it "applies custom CSS classes via classes parameter" do
      render_inline(described_class.new(classes: "my-custom-class")) { "Button" }

      expect(page).to have_css("button.my-custom-class")
    end

    it "forwards HTML attributes to the button element" do
      render_inline(described_class.new(id: "my-button", data: { testid: "submit" })) { "Button" }

      expect(page).to have_css("button#my-button")
      expect(page).to have_css("button[data-testid='submit']")
    end
  end

  # ==========================================================================
  # Variant Tests
  # ==========================================================================

  describe "variants" do
    context "with default variant" do
      it "applies primary background classes" do
        render_inline(described_class.new(variant: :default)) { "Default" }

        expect(page).to have_css("button.bg-primary")
        expect(page).to have_css("button.text-primary-foreground")
      end
    end

    context "with destructive variant" do
      it "applies destructive background classes" do
        render_inline(described_class.new(variant: :destructive)) { "Delete" }

        expect(page).to have_css("button.bg-destructive")
        expect(page).to have_css("button.text-white")
      end
    end

    context "with outline variant" do
      it "applies border and background classes" do
        render_inline(described_class.new(variant: :outline)) { "Cancel" }

        expect(page).to have_css("button.border")
        expect(page).to have_css("button.bg-background")
      end
    end

    context "with secondary variant" do
      it "applies secondary background classes" do
        render_inline(described_class.new(variant: :secondary)) { "Secondary" }

        expect(page).to have_css("button.bg-secondary")
        expect(page).to have_css("button.text-secondary-foreground")
      end
    end

    context "with ghost variant" do
      it "applies transparent background with hover classes" do
        render_inline(described_class.new(variant: :ghost)) { "Ghost" }

        expect(page).to have_css("button.hover\\:bg-accent")
      end
    end

    context "with link variant" do
      it "applies link styling classes" do
        render_inline(described_class.new(variant: :link)) { "Learn more" }

        expect(page).to have_css("button.text-primary")
        expect(page).to have_css("button.underline-offset-4")
      end
    end

    it "defaults to the default variant when not specified" do
      render_inline(described_class.new) { "Button" }

      expect(page).to have_css("button.bg-primary")
    end
  end

  # ==========================================================================
  # Size Tests
  # ==========================================================================

  describe "sizes" do
    context "with default size" do
      it "applies default height and padding" do
        render_inline(described_class.new(size: :default)) { "Default" }

        expect(page).to have_css("button.h-9")
        expect(page).to have_css("button.px-4")
      end
    end

    context "with sm size" do
      it "applies small height and padding" do
        render_inline(described_class.new(size: :sm)) { "Small" }

        expect(page).to have_css("button.h-8")
        expect(page).to have_css("button.px-3")
      end
    end

    context "with lg size" do
      it "applies large height and padding" do
        render_inline(described_class.new(size: :lg)) { "Large" }

        expect(page).to have_css("button.h-10")
        expect(page).to have_css("button.px-6")
      end
    end

    context "with icon size" do
      it "applies square dimensions" do
        render_inline(described_class.new(size: :icon)) { "+" }

        expect(page).to have_css("button.size-9")
      end
    end

    context "with icon_sm size" do
      it "applies small square dimensions" do
        render_inline(described_class.new(size: :icon_sm)) { "+" }

        expect(page).to have_css("button.size-8")
      end
    end

    context "with icon_lg size" do
      it "applies large square dimensions" do
        render_inline(described_class.new(size: :icon_lg)) { "+" }

        expect(page).to have_css("button.size-10")
      end
    end

    it "defaults to the default size when not specified" do
      render_inline(described_class.new) { "Button" }

      expect(page).to have_css("button.h-9")
    end
  end

  # ==========================================================================
  # Tag/Element Tests
  # ==========================================================================

  describe "tag option" do
    it "renders as a button by default" do
      render_inline(described_class.new) { "Button" }

      expect(page).to have_css("button")
    end

    it "can render as an anchor tag" do
      render_inline(described_class.new(tag: :a, href: "/dashboard")) { "Go to Dashboard" }

      expect(page).to have_css("a[href='/dashboard']")
      expect(page).to have_link("Go to Dashboard")
    end

    it "applies button styles to anchor tag" do
      render_inline(described_class.new(tag: :a, href: "#")) { "Link" }

      expect(page).to have_css("a.inline-flex")
      expect(page).to have_css("a.bg-primary")
    end
  end

  # ==========================================================================
  # Disabled State Tests
  # ==========================================================================

  describe "disabled state" do
    it "adds disabled attribute when disabled is true" do
      render_inline(described_class.new(disabled: true)) { "Disabled" }

      expect(page).to have_css("button[disabled]")
    end

    it "does not add disabled attribute when disabled is false" do
      render_inline(described_class.new(disabled: false)) { "Enabled" }

      expect(page).not_to have_css("button[disabled]")
    end

    it "applies disabled styling classes" do
      render_inline(described_class.new(disabled: true)) { "Disabled" }

      expect(page).to have_css("button.disabled\\:pointer-events-none")
      expect(page).to have_css("button.disabled\\:opacity-50")
    end
  end

  # ==========================================================================
  # Button Type Tests
  # ==========================================================================

  describe "type attribute" do
    it "defaults to button type" do
      render_inline(described_class.new) { "Button" }

      expect(page).to have_css("button[type='button']")
    end

    it "can be set to submit" do
      render_inline(described_class.new(type: :submit)) { "Submit" }

      expect(page).to have_css("button[type='submit']")
    end

    it "can be set to reset" do
      render_inline(described_class.new(type: :reset)) { "Reset" }

      expect(page).to have_css("button[type='reset']")
    end
  end

  # ==========================================================================
  # Accessibility Tests
  # ==========================================================================

  describe "accessibility" do
    it "accepts aria-label for icon buttons" do
      render_inline(described_class.new(size: :icon, aria_label: "Close dialog")) { "X" }

      expect(page).to have_css("button[aria-label='Close dialog']")
    end

    it "accepts aria-disabled attribute" do
      render_inline(described_class.new(aria_disabled: true)) { "Disabled" }

      expect(page).to have_css("button[aria-disabled='true']")
    end

    it "accepts aria-pressed for toggle buttons" do
      render_inline(described_class.new(aria_pressed: true)) { "Toggle" }

      expect(page).to have_css("button[aria-pressed='true']")
    end

    it "accepts aria-expanded for expandable content triggers" do
      render_inline(described_class.new(aria_expanded: false)) { "Expand" }

      expect(page).to have_css("button[aria-expanded='false']")
    end

    it "accepts aria-haspopup for menu triggers" do
      render_inline(described_class.new(aria_haspopup: "menu")) { "Menu" }

      expect(page).to have_css("button[aria-haspopup='menu']")
    end
  end

  # ==========================================================================
  # Composition Tests
  # ==========================================================================

  describe "composition" do
    it "renders text content" do
      render_inline(described_class.new) { "Click me" }

      expect(page).to have_button("Click me")
    end

    it "renders HTML content in the block" do
      render_inline(described_class.new) do
        "<span>Icon</span> Button".html_safe
      end

      expect(page).to have_css("button span", text: "Icon")
    end

    it "preserves whitespace between icon and text" do
      render_inline(described_class.new) { "Download" }

      expect(page).to have_css("button.gap-2")
    end
  end

  # ==========================================================================
  # Combined Prop Tests
  # ==========================================================================

  describe "combined props" do
    it "applies both variant and size classes" do
      render_inline(described_class.new(variant: :destructive, size: :lg)) { "Delete All" }

      expect(page).to have_css("button.bg-destructive")
      expect(page).to have_css("button.h-10")
    end

    it "combines custom classes with variant classes" do
      render_inline(described_class.new(variant: :outline, classes: "w-full")) { "Full Width" }

      expect(page).to have_css("button.border")
      expect(page).to have_css("button.w-full")
    end
  end
end
