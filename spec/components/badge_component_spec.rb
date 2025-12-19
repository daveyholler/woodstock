# frozen_string_literal: true

require "rails_helper"

RSpec.describe BadgeComponent, type: :component do
  # ==========================================================================
  # Rendering Tests
  # ==========================================================================

  describe "rendering" do
    it "renders a span element by default" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span")
    end

    it "renders the content passed in the block" do
      render_inline(described_class.new) { "New Feature" }

      expect(page).to have_css("span", text: "New Feature")
    end

    it "renders with base Tailwind classes" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.inline-flex")
      expect(page).to have_css("span.items-center")
      expect(page).to have_css("span.justify-center")
    end

    it "applies rounded-full for pill shape" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.rounded-full")
    end

    it "applies custom CSS classes via classes parameter" do
      render_inline(described_class.new(classes: "my-custom-class")) { "Badge" }

      expect(page).to have_css("span.my-custom-class")
    end

    it "forwards HTML attributes to the span element" do
      render_inline(described_class.new(id: "my-badge", data: { testid: "status" })) { "Badge" }

      expect(page).to have_css("span#my-badge")
      expect(page).to have_css("span[data-testid='status']")
    end
  end

  # ==========================================================================
  # Variant Tests
  # ==========================================================================

  describe "variants" do
    context "with default variant" do
      it "applies primary background classes" do
        render_inline(described_class.new(variant: :default)) { "Default" }

        expect(page).to have_css("span.bg-primary")
        expect(page).to have_css("span.text-primary-foreground")
      end

      it "hides the border" do
        render_inline(described_class.new(variant: :default)) { "Default" }

        expect(page).to have_css("span.border-0")
      end
    end

    context "with secondary variant" do
      it "applies secondary background classes" do
        render_inline(described_class.new(variant: :secondary)) { "Secondary" }

        expect(page).to have_css("span.bg-secondary")
        expect(page).to have_css("span.text-secondary-foreground")
      end

      it "hides the border" do
        render_inline(described_class.new(variant: :secondary)) { "Secondary" }

        expect(page).to have_css("span.border-0")
      end
    end

    context "with destructive variant" do
      it "applies destructive background classes" do
        render_inline(described_class.new(variant: :destructive)) { "Error" }

        expect(page).to have_css("span.bg-destructive")
        expect(page).to have_css("span.text-white")
      end

      it "hides the border" do
        render_inline(described_class.new(variant: :destructive)) { "Error" }

        expect(page).to have_css("span.border-0")
      end
    end

    context "with outline variant" do
      it "applies foreground text color" do
        render_inline(described_class.new(variant: :outline)) { "Outline" }

        expect(page).to have_css("span.text-foreground")
      end

      it "has visible border" do
        render_inline(described_class.new(variant: :outline)) { "Outline" }

        expect(page).not_to have_css("span.border-0")
      end
    end

    it "defaults to the default variant when not specified" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.bg-primary")
    end
  end

  # ==========================================================================
  # Typography Tests
  # ==========================================================================

  describe "typography" do
    it "applies extra small text size" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.text-xs")
    end

    it "applies medium font weight" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.font-medium")
    end

    it "prevents text wrapping" do
      render_inline(described_class.new) { "Long Badge Text" }

      expect(page).to have_css("span.whitespace-nowrap")
    end
  end

  # ==========================================================================
  # Spacing Tests
  # ==========================================================================

  describe "spacing" do
    it "applies horizontal padding" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.px-3")
    end

    it "applies vertical padding" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.py-0\\.5")
    end

    it "applies gap for icon spacing" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.gap-1")
    end
  end

  # ==========================================================================
  # Layout Tests
  # ==========================================================================

  describe "layout" do
    it "fits content width" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.w-fit")
    end

    it "prevents shrinking in flex containers" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.shrink-0")
    end

    it "clips overflowing content" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.overflow-hidden")
    end
  end

  # ==========================================================================
  # Accessibility Tests
  # ==========================================================================

  describe "accessibility" do
    it "accepts aria-label attribute" do
      render_inline(described_class.new(aria: { label: "Status indicator" })) { "New" }

      expect(page).to have_css("span[aria-label='Status indicator']")
    end

    it "accepts role attribute" do
      render_inline(described_class.new(role: "status")) { "Active" }

      expect(page).to have_css("span[role='status']")
    end

    it "applies focus-visible ring styles" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.focus-visible\\:ring-\\[3px\\]")
    end
  end

  # ==========================================================================
  # Composition Tests
  # ==========================================================================

  describe "composition" do
    it "renders text content" do
      render_inline(described_class.new) { "Status" }

      expect(page).to have_css("span", text: "Status")
    end

    it "renders HTML content in the block" do
      render_inline(described_class.new) do
        "<svg class=\"size-2\"></svg> Verified".html_safe
      end

      expect(page).to have_css("span svg.size-2")
    end

    it "applies icon sizing to child SVGs" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.\\[\\&\\>svg\\]\\:size-3")
    end

    it "disables pointer events on child SVGs" do
      render_inline(described_class.new) { "Badge" }

      expect(page).to have_css("span.\\[\\&\\>svg\\]\\:pointer-events-none")
    end
  end

  # ==========================================================================
  # Combined Prop Tests
  # ==========================================================================

  describe "combined props" do
    it "combines custom classes with variant classes" do
      render_inline(described_class.new(variant: :secondary, classes: "uppercase")) { "Beta" }

      expect(page).to have_css("span.bg-secondary")
      expect(page).to have_css("span.uppercase")
    end

    it "allows overriding default styles with custom classes" do
      render_inline(described_class.new(classes: "rounded-md px-3")) { "Custom" }

      expect(page).to have_css("span.rounded-md")
      expect(page).to have_css("span.px-3")
    end
  end

  # ==========================================================================
  # Edge Cases
  # ==========================================================================

  describe "edge cases" do
    it "handles empty content" do
      render_inline(described_class.new) { "" }

      expect(page).to have_css("span")
    end

    it "handles numeric content" do
      render_inline(described_class.new) { "99" }

      expect(page).to have_css("span", text: "99")
    end

    it "handles special characters" do
      render_inline(described_class.new) { "99+" }

      expect(page).to have_css("span", text: "99+")
    end
  end
end
