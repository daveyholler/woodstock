# frozen_string_literal: true

require "rails_helper"

RSpec.describe BreadcrumbComponent, type: :component do
  # ==========================================================================
  # Rendering Tests
  # ==========================================================================

  describe "rendering" do
    it "renders a nav element as root" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav")
    end

    it "renders with aria-label for accessibility" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav[aria-label='breadcrumb']")
    end

    it "renders an ordered list inside nav" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav > ol")
    end

    it "renders with data-slot attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav[data-slot='breadcrumb']")
    end

    it "applies custom classes to root element" do
      render_inline(described_class.new(classes: "my-custom-class")) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav.my-custom-class")
    end

    it "forwards HTML attributes to nav element" do
      render_inline(described_class.new(id: "main-breadcrumb", data: { testid: "nav" })) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav#main-breadcrumb")
      expect(page).to have_css("nav[data-testid='nav']")
    end
  end

  # ==========================================================================
  # BreadcrumbList Tests
  # ==========================================================================

  describe "breadcrumb list" do
    it "applies flex layout classes" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol.flex")
      expect(page).to have_css("ol.flex-wrap")
    end

    it "applies alignment classes" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol.items-center")
    end

    it "applies gap spacing classes" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol.gap-1\\.5")
    end

    it "applies responsive gap on larger screens" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol.sm\\:gap-2\\.5")
    end

    it "applies typography classes" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol.text-sm")
      expect(page).to have_css("ol.text-muted-foreground")
    end

    it "applies break-words class" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol.break-words")
    end

    it "has data-slot attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("ol[data-slot='breadcrumb-list']")
    end
  end

  # ==========================================================================
  # BreadcrumbItem Tests
  # ==========================================================================

  describe "breadcrumb items" do
    it "renders items as list items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li", count: 3) # 2 items + 1 separator
    end

    it "applies inline-flex layout to items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("li.inline-flex")
    end

    it "applies alignment to items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("li.items-center")
    end

    it "applies gap between item content" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("li.gap-1\\.5")
    end

    it "has data-slot attribute on items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("li[data-slot='breadcrumb-item']")
    end

    it "renders multiple items in order" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/products") { "Products" }
        bc.with_item(current: true) { "Widget" }
      end

      items = page.all("li[data-slot='breadcrumb-item']")
      expect(items[0]).to have_text("Home")
      expect(items[1]).to have_text("Products")
      expect(items[2]).to have_text("Widget")
    end
  end

  # ==========================================================================
  # BreadcrumbLink Tests
  # ==========================================================================

  describe "breadcrumb links" do
    it "renders links with href attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/home") { "Home" }
      end

      expect(page).to have_css("a[href='/home']")
    end

    it "applies hover color transition" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("a.hover\\:text-foreground")
    end

    it "applies transition-colors class" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("a.transition-colors")
    end

    it "has data-slot attribute on links" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("a[data-slot='breadcrumb-link']")
    end

    it "renders link text content" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home Page" }
      end

      expect(page).to have_link("Home Page")
    end

    it "accepts custom classes on links" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/", classes: "font-bold") { "Home" }
      end

      expect(page).to have_css("a.font-bold")
    end
  end

  # ==========================================================================
  # BreadcrumbPage Tests
  # ==========================================================================

  describe "current page" do
    it "renders current item as span instead of link" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current Page" }
      end

      expect(page).to have_css("span", text: "Current Page")
      expect(page).not_to have_css("a", text: "Current Page")
    end

    it "applies foreground text color" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span.text-foreground")
    end

    it "applies normal font weight" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span.font-normal")
    end

    it "has role=link attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[role='link']")
    end

    it "has aria-disabled=true attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[aria-disabled='true']")
    end

    it "has aria-current=page attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[aria-current='page']")
    end

    it "has data-slot attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[data-slot='breadcrumb-page']")
    end
  end

  # ==========================================================================
  # BreadcrumbSeparator Tests
  # ==========================================================================

  describe "separators" do
    it "renders separators between items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li[data-slot='breadcrumb-separator']", count: 1)
    end

    it "renders correct number of separators" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/products") { "Products" }
        bc.with_item(current: true) { "Widget" }
      end

      expect(page).to have_css("li[data-slot='breadcrumb-separator']", count: 2)
    end

    it "does not render separator after last item" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(current: true) { "Current" }
      end

      separators = page.all("li[data-slot='breadcrumb-separator']")
      items = page.all("li[data-slot='breadcrumb-item']")

      # Last element should be an item, not a separator
      last_li = page.all("ol > li").last
      expect(last_li["data-slot"]).to eq("breadcrumb-item")
    end

    it "has role=presentation attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li[role='presentation']")
    end

    it "has aria-hidden=true attribute" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li[aria-hidden='true']")
    end

    it "applies SVG sizing class" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li.\\[\\&\\>svg\\]\\:size-3\\.5")
    end

    it "renders chevron-right icon by default" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li[data-slot='breadcrumb-separator'] svg")
    end

    it "allows custom separator icon" do
      render_inline(described_class.new(separator_icon: "slash")) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li[data-slot='breadcrumb-separator'] svg")
    end

    it "allows disabling separator on specific items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/", separator: false) { "Home" }
        bc.with_item(current: true) { "Current" }
      end

      expect(page).not_to have_css("li[data-slot='breadcrumb-separator']")
    end
  end

  # ==========================================================================
  # BreadcrumbEllipsis Tests
  # ==========================================================================

  describe "ellipsis" do
    it "renders ellipsis item when specified" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("[data-slot='breadcrumb-ellipsis']")
    end

    it "applies flex layout classes to ellipsis" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span.flex")
    end

    it "applies size classes to ellipsis" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span.size-9")
    end

    it "applies centering classes to ellipsis" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span.items-center")
      expect(page).to have_css("span.justify-center")
    end

    it "has role=presentation attribute on ellipsis" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[role='presentation']")
    end

    it "has aria-hidden=true attribute on ellipsis" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[aria-hidden='true']")
    end

    it "includes screen reader text for ellipsis" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span.sr-only", text: "More")
    end

    it "renders ellipsis icon" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(ellipsis: true)
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("[data-slot='breadcrumb-ellipsis'] svg")
    end
  end

  # ==========================================================================
  # Accessibility Tests
  # ==========================================================================

  describe "accessibility" do
    it "has proper landmark navigation" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav[aria-label='breadcrumb']")
    end

    it "uses semantic ordered list" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav > ol")
    end

    it "marks separators as presentational" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/about") { "About" }
      end

      expect(page).to have_css("li[role='presentation'][aria-hidden='true']")
    end

    it "marks current page correctly" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(current: true) { "Current" }
      end

      expect(page).to have_css("span[aria-current='page']")
    end

    it "accepts custom aria-label" do
      render_inline(described_class.new(aria: { label: "Site navigation" })) do |bc|
        bc.with_item(href: "/") { "Home" }
      end

      expect(page).to have_css("nav[aria-label='Site navigation']")
    end
  end

  # ==========================================================================
  # Composition Tests
  # ==========================================================================

  describe "composition" do
    it "renders a complete breadcrumb trail" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home" }
        bc.with_item(href: "/products") { "Products" }
        bc.with_item(href: "/products/electronics") { "Electronics" }
        bc.with_item(current: true) { "Laptop" }
      end

      expect(page).to have_link("Home", href: "/")
      expect(page).to have_link("Products", href: "/products")
      expect(page).to have_link("Electronics", href: "/products/electronics")
      expect(page).to have_css("span", text: "Laptop")
      expect(page).to have_css("li[data-slot='breadcrumb-separator']", count: 3)
    end

    it "renders HTML content in items" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") do
          "<svg class='size-4'></svg> Home".html_safe
        end
      end

      expect(page).to have_css("a svg.size-4")
    end

    it "handles single item breadcrumb" do
      render_inline(described_class.new) do |bc|
        bc.with_item(current: true) { "Home" }
      end

      expect(page).to have_css("span", text: "Home")
      expect(page).not_to have_css("li[data-slot='breadcrumb-separator']")
    end
  end

  # ==========================================================================
  # Edge Cases
  # ==========================================================================

  describe "edge cases" do
    it "handles empty breadcrumb gracefully" do
      render_inline(described_class.new)

      expect(page).to have_css("nav[aria-label='breadcrumb']")
      expect(page).to have_css("ol")
    end

    it "handles items without content" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "" }
      end

      expect(page).to have_css("a[href='/']")
    end

    it "handles special characters in content" do
      render_inline(described_class.new) do |bc|
        bc.with_item(href: "/") { "Home & Garden" }
      end

      expect(page).to have_link("Home & Garden")
    end

    it "handles long breadcrumb trails" do
      render_inline(described_class.new) do |bc|
        10.times do |i|
          if i == 9
            bc.with_item(current: true) { "Page #{i + 1}" }
          else
            bc.with_item(href: "/page-#{i + 1}") { "Page #{i + 1}" }
          end
        end
      end

      expect(page).to have_css("li[data-slot='breadcrumb-item']", count: 10)
      expect(page).to have_css("li[data-slot='breadcrumb-separator']", count: 9)
    end
  end
end
