# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlertDialogComponent, type: :component do
  # ==========================================================================
  # Rendering Tests
  # ==========================================================================

  describe "rendering" do
    it "renders the root element with correct data attributes" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description { "Description" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-controller='alert-dialog']")
    end

    it "applies custom CSS classes via classes parameter" do
      render_inline(described_class.new(classes: "custom-class")) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-controller='alert-dialog'].custom-class")
    end

    it "forwards HTML attributes to root element" do
      render_inline(described_class.new(id: "delete-dialog", data: { testid: "alert-dialog" })) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("#delete-dialog")
      expect(page).to have_css("[data-testid='alert-dialog']")
    end
  end

  # ==========================================================================
  # Trigger Tests
  # ==========================================================================

  describe "trigger" do
    it "renders the trigger slot" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Delete Account" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_button("Delete Account")
    end

    it "renders trigger with correct data-slot attribute" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-trigger']")
    end

    it "applies Stimulus action for opening dialog" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-trigger'][data-action*='alert-dialog#open']")
    end

    it "accepts custom classes for trigger" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger(classes: "w-full") { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-trigger'].w-full")
    end
  end

  # ==========================================================================
  # Dialog Tests
  # ==========================================================================

  describe "dialog element" do
    it "renders the dialog element" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("dialog", visible: :all)
    end

    it "applies backdrop styling via CSS" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("dialog.backdrop\\:bg-black\\/50", visible: :all)
    end

    it "applies basic dialog styling" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("dialog.bg-transparent", visible: :all)
      expect(page).to have_css("dialog.data-\\[state\\=open\\]\\:animate-in", visible: :all)
      expect(page).to have_css("dialog.data-\\[state\\=closed\\]\\:animate-out", visible: :all)
    end

    it "accepts custom classes for dialog" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body(classes: "max-w-md") do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("dialog.max-w-md", visible: :all)
    end
  end

  # ==========================================================================
  # Content Wrapper Tests
  # ==========================================================================

  describe "content wrapper" do
    it "renders content with styling classes" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("dialog > div.bg-background", visible: :all)
      expect(page).to have_css("dialog > div.rounded-lg", visible: :all)
      expect(page).to have_css("dialog > div.border", visible: :all)
      expect(page).to have_css("dialog > div.shadow-lg", visible: :all)
    end
  end

  # ==========================================================================
  # Header Tests
  # ==========================================================================

  describe "header" do
    it "renders the header section" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description { "Description" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-header']", visible: :all)
    end

    it "applies flex layout classes to header" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-header'].flex", visible: :all)
      expect(page).to have_css("[data-slot='alert-dialog-header'].flex-col", visible: :all)
      expect(page).to have_css("[data-slot='alert-dialog-header'].gap-2", visible: :all)
    end
  end

  # ==========================================================================
  # Title Tests
  # ==========================================================================

  describe "title" do
    it "renders the title" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Are you absolutely sure?" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-title']", text: "Are you absolutely sure?", visible: :all)
    end

    it "applies typography classes to title" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-title'].text-lg", visible: :all)
      expect(page).to have_css("[data-slot='alert-dialog-title'].font-semibold", visible: :all)
    end

    it "accepts custom classes for title" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title(classes: "text-red-500") { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-title'].text-red-500", visible: :all)
    end
  end

  # ==========================================================================
  # Description Tests
  # ==========================================================================

  describe "description" do
    it "renders the description" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description { "This action cannot be undone." }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-description']", text: "This action cannot be undone.", visible: :all)
    end

    it "applies typography classes to description" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description { "Description text" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-description'].text-sm", visible: :all)
      expect(page).to have_css("[data-slot='alert-dialog-description'].text-muted-foreground", visible: :all)
    end

    it "accepts custom classes for description" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description(classes: "text-center") { "Description" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-description'].text-center", visible: :all)
    end
  end

  # ==========================================================================
  # Footer Tests
  # ==========================================================================

  describe "footer" do
    it "renders the footer section" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-footer']", visible: :all)
    end

    it "applies flex layout classes to footer" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-footer'].flex", visible: :all)
      expect(page).to have_css("[data-slot='alert-dialog-footer'].gap-2", visible: :all)
    end
  end

  # ==========================================================================
  # Action Button Tests
  # ==========================================================================

  describe "action button" do
    it "renders the action button" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Delete" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-action']", text: "Delete", visible: :all)
    end

    it "applies button styling to action" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-action'].inline-flex", visible: :all)
    end

    it "applies Stimulus action for closing dialog" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-action'][data-action*='alert-dialog#close']", visible: :all)
    end

    it "accepts custom classes for action button" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action(classes: "bg-red-600") { "Delete" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-action'].bg-red-600", visible: :all)
    end
  end

  # ==========================================================================
  # Cancel Button Tests
  # ==========================================================================

  describe "cancel button" do
    it "renders the cancel button" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-cancel']", text: "Cancel", visible: :all)
    end

    it "applies outline button styling to cancel" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-cancel'].border", visible: :all)
    end

    it "applies Stimulus action for closing dialog" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-cancel'][data-action*='alert-dialog#close']", visible: :all)
    end

    it "accepts custom classes for cancel button" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel(classes: "w-full") { "Go Back" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-cancel'].w-full", visible: :all)
    end
  end

  # ==========================================================================
  # State Tests
  # ==========================================================================

  describe "state" do
    it "starts with data-state closed" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-controller='alert-dialog'][data-alert-dialog-open-value='false']")
    end

    it "always starts closed" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-controller='alert-dialog'][data-alert-dialog-open-value='false']")
    end
  end

  # ==========================================================================
  # Accessibility Tests
  # ==========================================================================

  describe "accessibility" do
    it "dialog has proper aria attributes" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("dialog[aria-labelledby]", visible: :all)
    end

    it "dialog has aria-labelledby pointing to title" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      dialog_el = page.find("dialog", visible: :all)
      title_id = dialog_el["aria-labelledby"]
      expect(page).to have_css("[data-slot='alert-dialog-title']##{title_id}", visible: :all)
    end

    it "dialog has aria-describedby pointing to description when present" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description { "Description" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      dialog_el = page.find("dialog", visible: :all)
      desc_id = dialog_el["aria-describedby"]
      expect(page).to have_css("[data-slot='alert-dialog-description']##{desc_id}", visible: :all)
    end

    it "trigger has aria-haspopup dialog" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-trigger'][aria-haspopup='dialog']")
    end

    it "trigger has aria-expanded attribute" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-trigger'][aria-expanded='false']")
    end
  end

  # ==========================================================================
  # Stimulus Data Attributes Tests
  # ==========================================================================

  describe "stimulus data attributes" do
    it "has alert-dialog controller on root" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-controller='alert-dialog']")
    end

    it "has dialog target on dialog element" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-alert-dialog-target='dialog']", visible: :all)
    end
  end

  # ==========================================================================
  # Composition Tests
  # ==========================================================================

  describe "composition" do
    it "renders HTML content in title" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "<strong>Warning</strong>".html_safe }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-title'] strong", text: "Warning", visible: :all)
    end

    it "renders HTML content in description" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger { "Open" }
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_description { "<em>Important notice</em>".html_safe }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-description'] em", text: "Important notice", visible: :all)
    end

    it "renders trigger with icons" do
      render_inline(described_class.new) do |dialog|
        dialog.with_trigger do
          "<svg class='icon'></svg> Delete".html_safe
        end
        dialog.with_body do |body|
          body.with_title { "Title" }
          body.with_cancel { "Cancel" }
          body.with_action { "Continue" }
        end
      end

      expect(page).to have_css("[data-slot='alert-dialog-trigger'] svg.icon")
    end
  end
end
