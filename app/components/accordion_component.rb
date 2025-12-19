# frozen_string_literal: true

class AccordionComponent < ViewComponent::Base
  # Renders an accordion component based on shadcn-ui
  #
  # @example Basic usage
  #   <%= render AccordionComponent.new do |accordion| %>
  #     <% accordion.with_item(value: "item-1") do |item| %>
  #       <% item.with_trigger { "Is it accessible?" } %>
  #       <% item.with_body { "Yes. It adheres to the WAI-ARIA design pattern." } %>
  #     <% end %>
  #   <% end %>
  #
  # @example Single collapsible (allows closing all items)
  #   <%= render AccordionComponent.new(type: :single, collapsible: true) do |accordion| %>
  #     ...
  #   <% end %>
  #
  # @example Multiple items open simultaneously
  #   <%= render AccordionComponent.new(type: :multiple) do |accordion| %>
  #     ...
  #   <% end %>
  #
  # @example With default open item
  #   <%= render AccordionComponent.new(default_value: "item-1") do |accordion| %>
  #     ...
  #   <% end %>

  TYPES = %i[single multiple].freeze

  renders_many :items, ->(value:, disabled: false, classes: nil, &block) {
    ItemSlot.new(value: value, disabled: disabled, classes: classes, block: block)
  }

  def initialize(
    type: :single,
    collapsible: false,
    default_value: nil,
    classes: nil,
    **html_attributes
  )
    @type = type.to_sym
    @collapsible = collapsible
    @default_value = default_value
    @classes = classes
    @html_attributes = html_attributes

    validate_type!
  end

  private

  def validate_type!
    return if TYPES.include?(@type)

    raise ArgumentError, "Invalid type: #{@type}. Must be one of: #{TYPES.join(', ')}"
  end

  def component_classes
    [@classes].compact.join(" ")
  end

  def data_attributes
    {
      controller: "accordion",
      "accordion-type-value": @type.to_s,
      "accordion-collapsible-value": @collapsible.to_s,
      "accordion-default-value-value": default_value_string
    }.compact
  end

  def default_value_string
    return nil if @default_value.nil?

    @default_value.is_a?(Array) ? @default_value.to_json : @default_value.to_s
  end

  def default_open?(value)
    return false if @default_value.nil?

    if @default_value.is_a?(Array)
      @default_value.include?(value)
    else
      @default_value.to_s == value.to_s
    end
  end

  # ==========================================================================
  # ItemSlot - Individual accordion item
  # ==========================================================================

  class ItemSlot < ViewComponent::Base
    attr_reader :value, :disabled

    def initialize(value:, disabled: false, classes: nil, block: nil)
      @value = value
      @disabled = disabled
      @classes = classes
      @item_id = "accordion-item-#{value}"
      @block = block
      @trigger_content = nil
      @trigger_classes = nil
      @body_content = nil
      @body_classes = nil
    end

    def with_trigger(classes: nil, &block)
      @trigger_classes = classes
      @trigger_content = block
    end

    def with_body(classes: nil, &block)
      @body_classes = classes
      @body_content = block
    end

    def before_render
      # Execute the block to capture trigger and body definitions
      @block&.call(self)
    end

    def call
      tag.div(
        class: item_classes,
        data: item_data_attributes
      ) do
        safe_join([
          render_trigger,
          render_body
        ].compact)
      end
    end

    def trigger_id
      "#{@item_id}-trigger"
    end

    def body_id
      "#{@item_id}-body"
    end

    def open?
      @open || false
    end

    def open=(value)
      @open = value
    end

    private

    def item_classes
      class_names(
        "border-b last:border-b-0",
        @classes
      )
    end

    def item_data_attributes
      attrs = {
        slot: "accordion-item",
        state: open? ? "open" : "closed",
        value: @value,
        "accordion-target": "item"
      }
      attrs[:disabled] = "" if @disabled
      attrs
    end

    def render_trigger
      return nil unless @trigger_content

      tag.h3(class: "flex") do
        tag.button(
          class: trigger_classes,
          type: "button",
          disabled: @disabled || nil,
          aria: {
            expanded: open?.to_s,
            controls: body_id
          },
          id: trigger_id,
          data: trigger_data_attributes
        ) do
          safe_join([
            view_context.capture(&@trigger_content),
            chevron_icon
          ])
        end
      end
    end

    def trigger_classes
      class_names(
        # Layout
        "flex flex-1 items-center justify-between gap-4",
        # Spacing
        "py-4",
        # Typography
        "text-left text-sm font-medium",
        # Interactive
        "rounded-md transition-all outline-none",
        "hover:underline",
        # Focus states
        "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
        # Disabled states
        "disabled:pointer-events-none disabled:opacity-50",
        # Chevron rotation on open
        "[&[aria-expanded=true]>svg]:rotate-180",
        # Custom classes
        @trigger_classes
      )
    end

    def trigger_data_attributes
      {
        slot: "accordion-trigger",
        "accordion-target": "trigger",
        action: "click->accordion#toggle"
      }
    end

    def chevron_icon
      tag.svg(
        xmlns: "http://www.w3.org/2000/svg",
        width: "16",
        height: "16",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round",
        class: "text-muted-foreground pointer-events-none size-4 shrink-0 transition-transform duration-200",
        aria: { hidden: "true" }
      ) do
        tag.path(d: "m6 9 6 6 6-6")
      end
    end

    def render_body
      return nil unless @body_content

      tag.div(
        id: body_id,
        class: body_classes,
        role: "region",
        aria: { labelledby: trigger_id },
        data: body_data_attributes
      ) do
        tag.div(view_context.capture(&@body_content), class: inner_classes)
      end
    end

    def body_classes
      class_names(
        "text-sm"
      )
    end

    def body_data_attributes
      {
        slot: "accordion-body",
        "accordion-target": "body",
        state: open? ? "open" : "closed"
      }
    end

    def inner_classes
      class_names(
        "pt-0 pb-4",
        @body_classes
      )
    end
  end
end
