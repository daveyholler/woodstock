# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccordionComponent, type: :component do
  # ==========================================================================
  # Rendering Tests
  # ==========================================================================

  describe "rendering" do
    it "renders the root element with correct data attributes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-controller='accordion']")
    end

    it "renders with base Tailwind classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("div[data-controller='accordion']")
    end

    it "applies custom CSS classes via classes parameter" do
      render_inline(described_class.new(classes: "w-full max-w-lg")) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-controller='accordion'].w-full")
      expect(page).to have_css("[data-controller='accordion'].max-w-lg")
    end

    it "forwards HTML attributes to root element" do
      render_inline(described_class.new(id: "faq-accordion", data: { testid: "accordion" })) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("#faq-accordion")
      expect(page).to have_css("[data-testid='accordion']")
    end
  end

  # ==========================================================================
  # Type Tests
  # ==========================================================================

  describe "type" do
    context "with single type" do
      it "sets data-type attribute to single" do
        render_inline(described_class.new(type: :single)) do |accordion|
          accordion.with_item(value: "item-1") do |item|
            item.with_trigger { "Question" }
            item.with_body { "Answer" }
          end
        end

        expect(page).to have_css("[data-accordion-type-value='single']")
      end
    end

    context "with multiple type" do
      it "sets data-type attribute to multiple" do
        render_inline(described_class.new(type: :multiple)) do |accordion|
          accordion.with_item(value: "item-1") do |item|
            item.with_trigger { "Question" }
            item.with_body { "Answer" }
          end
        end

        expect(page).to have_css("[data-accordion-type-value='multiple']")
      end
    end

    it "defaults to single type when not specified" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-type-value='single']")
    end
  end

  # ==========================================================================
  # Collapsible Tests
  # ==========================================================================

  describe "collapsible" do
    it "sets data-collapsible attribute when true" do
      render_inline(described_class.new(collapsible: true)) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-collapsible-value='true']")
    end

    it "sets data-collapsible attribute when false" do
      render_inline(described_class.new(collapsible: false)) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-collapsible-value='false']")
    end

    it "defaults to false when not specified" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-collapsible-value='false']")
    end
  end

  # ==========================================================================
  # Default Value Tests
  # ==========================================================================

  describe "default_value" do
    it "sets initial open state for matching item" do
      render_inline(described_class.new(default_value: "item-2")) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question 1" }
          item.with_body { "Answer 1" }
        end
        accordion.with_item(value: "item-2") do |item|
          item.with_trigger { "Question 2" }
          item.with_body { "Answer 2" }
        end
      end

      expect(page).to have_css("[data-accordion-default-value-value='item-2']")
    end

    it "supports array of values for multiple type" do
      render_inline(described_class.new(type: :multiple, default_value: ["item-1", "item-3"])) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question 1" }
          item.with_body { "Answer 1" }
        end
        accordion.with_item(value: "item-2") do |item|
          item.with_trigger { "Question 2" }
          item.with_body { "Answer 2" }
        end
        accordion.with_item(value: "item-3") do |item|
          item.with_trigger { "Question 3" }
          item.with_body { "Answer 3" }
        end
      end

      expect(page).to have_css("[data-accordion-default-value-value]")
    end
  end

  # ==========================================================================
  # AccordionItem Tests
  # ==========================================================================

  describe "AccordionItem" do
    it "renders with correct data-slot attribute" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item']")
    end

    it "applies border styling" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'].border-b")
    end

    it "removes border from last item" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'].last\\:border-b-0")
    end

    it "sets data-state to closed by default" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'][data-state='closed']")
    end

    it "sets data-state to open when matching default_value" do
      render_inline(described_class.new(default_value: "item-1")) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'][data-state='open']")
    end

    it "includes value as data attribute" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "faq-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'][data-value='faq-1']")
    end

    it "accepts custom classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1", classes: "custom-item") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'].custom-item")
    end
  end

  # ==========================================================================
  # AccordionTrigger Tests
  # ==========================================================================

  describe "AccordionTrigger" do
    it "renders as a button element" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Click me" }
          item.with_body { "Content" }
        end
      end

      expect(page).to have_button("Click me")
    end

    it "renders with correct data-slot attribute" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger']")
    end

    it "applies flex layout classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'].flex")
      expect(page).to have_css("[data-slot='accordion-trigger'].flex-1")
      expect(page).to have_css("[data-slot='accordion-trigger'].items-center")
      expect(page).to have_css("[data-slot='accordion-trigger'].justify-between")
    end

    it "applies typography classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'].text-sm")
      expect(page).to have_css("[data-slot='accordion-trigger'].font-medium")
    end

    it "applies hover styling" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'].hover\\:underline")
    end

    it "renders the chevron icon" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'] svg")
    end

    it "applies Stimulus action for toggle" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'][data-action*='accordion#toggle']")
    end

    it "accepts custom classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger(classes: "custom-trigger") { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'].custom-trigger")
    end
  end

  # ==========================================================================
  # AccordionBody Tests (renamed from AccordionContent)
  # ==========================================================================

  describe "AccordionBody" do
    it "renders with correct data-slot attribute" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer content" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body']", visible: :all)
    end

    it "renders the content" do
      render_inline(described_class.new(default_value: "item-1")) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "This is the answer" }
        end
      end

      expect(page).to have_content("This is the answer")
    end

    it "applies typography classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body'].text-sm", visible: :all)
    end

    it "has inner div with padding" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body'] > div.pb-4", visible: :all)
    end

    it "accepts custom classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body(classes: "custom-body") { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body'] > div.custom-body", visible: :all)
    end
  end

  # ==========================================================================
  # Disabled State Tests
  # ==========================================================================

  describe "disabled state" do
    it "adds disabled attribute to item when disabled" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1", disabled: true) do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item'][data-disabled]")
    end

    it "adds disabled attribute to trigger when item is disabled" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1", disabled: true) do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'][disabled]")
    end

    it "applies disabled styling classes" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1", disabled: true) do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'].disabled\\:pointer-events-none")
      expect(page).to have_css("[data-slot='accordion-trigger'].disabled\\:opacity-50")
    end
  end

  # ==========================================================================
  # Accessibility Tests
  # ==========================================================================

  describe "accessibility" do
    it "trigger has aria-expanded attribute" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'][aria-expanded]")
    end

    it "trigger aria-expanded is false when closed" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'][aria-expanded='false']")
    end

    it "trigger aria-expanded is true when open" do
      render_inline(described_class.new(default_value: "item-1")) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'][aria-expanded='true']")
    end

    it "trigger has aria-controls pointing to body" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'][aria-controls]")
    end

    it "body has id matching trigger aria-controls" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      trigger = page.find("[data-slot='accordion-trigger']")
      body_id = trigger["aria-controls"]
      expect(page).to have_css("[data-slot='accordion-body']##{body_id}", visible: :all)
    end

    it "body has role region" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body'][role='region']", visible: :all)
    end

    it "body has aria-labelledby pointing to trigger" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body'][aria-labelledby]", visible: :all)
    end
  end

  # ==========================================================================
  # Composition Tests
  # ==========================================================================

  describe "composition" do
    it "renders multiple items" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question 1" }
          item.with_body { "Answer 1" }
        end
        accordion.with_item(value: "item-2") do |item|
          item.with_trigger { "Question 2" }
          item.with_body { "Answer 2" }
        end
        accordion.with_item(value: "item-3") do |item|
          item.with_trigger { "Question 3" }
          item.with_body { "Answer 3" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-item']", count: 3)
    end

    it "renders HTML content in trigger" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "<strong>Bold Question</strong>".html_safe }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-slot='accordion-trigger'] strong", text: "Bold Question")
    end

    it "renders HTML content in body" do
      render_inline(described_class.new(default_value: "item-1")) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "<p>Paragraph 1</p><p>Paragraph 2</p>".html_safe }
        end
      end

      expect(page).to have_css("[data-slot='accordion-body'] p", count: 2)
    end
  end

  # ==========================================================================
  # Stimulus Controller Tests
  # ==========================================================================

  describe "stimulus data attributes" do
    it "has accordion controller on root" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-controller='accordion']")
    end

    it "has item target on accordion items" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-target='item']")
    end

    it "has trigger target on triggers" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-target='trigger']")
    end

    it "has body target on body elements" do
      render_inline(described_class.new) do |accordion|
        accordion.with_item(value: "item-1") do |item|
          item.with_trigger { "Question" }
          item.with_body { "Answer" }
        end
      end

      expect(page).to have_css("[data-accordion-target='body']", visible: :all)
    end
  end
end
