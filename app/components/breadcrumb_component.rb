# frozen_string_literal: true

class BreadcrumbComponent < ViewComponent::Base
  # Renders a breadcrumb navigation component based on shadcn-ui
  #
  # @example Basic usage
  #   <%= render BreadcrumbComponent.new do |bc| %>
  #     <% bc.with_item(href: "/") do %>Home<% end %>
  #     <% bc.with_item(href: "/products") do %>Products<% end %>
  #     <% bc.with_item(current: true) do %>Widget<% end %>
  #   <% end %>
  #
  # @example With custom separator icon
  #   <%= render BreadcrumbComponent.new(separator_icon: "slash") do |bc| %>
  #     <% bc.with_item(href: "/") do %>Home<% end %>
  #     <% bc.with_item(current: true) do %>About<% end %>
  #   <% end %>
  #
  # @example With ellipsis for collapsed items
  #   <%= render BreadcrumbComponent.new do |bc| %>
  #     <% bc.with_item(href: "/") do %>Home<% end %>
  #     <% bc.with_item(ellipsis: true) %>
  #     <% bc.with_item(href: "/components") do %>Components<% end %>
  #     <% bc.with_item(current: true) do %>Breadcrumb<% end %>
  #   <% end %>

  renders_many :items, "ItemSlot"

  def initialize(
    separator_icon: "chevron-right",
    classes: nil,
    **html_attributes
  )
    @separator_icon = separator_icon
    @classes = classes
    @html_attributes = html_attributes
  end

  def nav_attributes
    default_aria = { label: "breadcrumb" }
    aria = @html_attributes.delete(:aria) || {}

    {
      class: nav_classes,
      "aria-label": aria[:label] || default_aria[:label],
      data: { slot: "breadcrumb" }
    }.merge(@html_attributes).compact
  end

  def nav_classes
    @classes
  end

  def list_classes
    [
      "flex flex-wrap items-center",
      "gap-1.5 sm:gap-2.5",
      "text-sm text-muted-foreground",
      "break-words"
    ].join(" ")
  end

  def separator_icon
    @separator_icon
  end

  class ItemSlot < ViewComponent::Base
    def initialize(
      href: nil,
      current: false,
      ellipsis: false,
      separator: true,
      classes: nil
    )
      @href = href
      @current = current
      @ellipsis = ellipsis
      @separator = separator
      @classes = classes
    end

    attr_reader :href, :separator

    def current?
      @current
    end

    def ellipsis?
      @ellipsis
    end

    def link?
      @href.present? && !current? && !ellipsis?
    end

    def item_classes
      "inline-flex items-center gap-1.5"
    end

    def link_classes
      [
        "hover:text-foreground flex gap-1.5 items-center justify-center transition-colors",
        @classes
      ].compact.join(" ")
    end

    def page_classes
      [
        "text-foreground font-normal flex gap-1.5 items-center",
        @classes
      ].compact.join(" ")
    end

    def ellipsis_classes
      "flex size-9 items-center justify-center"
    end

    def call
      # This slot renders via the parent template
      content
    end
  end
end
