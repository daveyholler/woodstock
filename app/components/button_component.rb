# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  # Renders a button component based on shadcn-ui
  #
  # @example Basic usage
  #   <%= render ButtonComponent.new do %>
  #     Click me
  #   <% end %>
  #
  # @example With variant and size
  #   <%= render ButtonComponent.new(variant: :destructive, size: :lg) do %>
  #     Delete
  #   <% end %>
  #
  # @example Icon button
  #   <%= render ButtonComponent.new(size: :icon, aria_label: "Settings") do %>
  #     <%= lucide_icon("settings") %>
  #   <% end %>
  #
  # @example As a link
  #   <%= render ButtonComponent.new(tag: :a, href: "/dashboard") do %>
  #     Go to Dashboard
  #   <% end %>

  VARIANTS = %i[default destructive outline secondary ghost link].freeze
  SIZES = %i[default sm lg icon icon_sm icon_lg].freeze
  TYPES = %i[button submit reset].freeze

  def initialize(
    variant: :default,
    size: :default,
    tag: :button,
    type: :button,
    disabled: false,
    classes: nil,
    **html_attributes
  )
    @variant = variant.to_sym
    @size = size.to_sym
    @tag = tag.to_sym
    @type = type.to_sym
    @disabled = disabled
    @classes = classes
    @html_attributes = html_attributes

    validate_variant!
    validate_size!
  end

  def call
    content_tag(@tag, content, **tag_attributes)
  end

  private

  def validate_variant!
    return if VARIANTS.include?(@variant)

    raise ArgumentError, "Invalid variant: #{@variant}. Must be one of: #{VARIANTS.join(', ')}"
  end

  def validate_size!
    return if SIZES.include?(@size)

    raise ArgumentError, "Invalid size: #{@size}. Must be one of: #{SIZES.join(', ')}"
  end

  def tag_attributes
    attrs = {
      class: component_classes,
      disabled: @disabled || nil
    }

    # Only add type attribute for button elements
    attrs[:type] = @type.to_s if @tag == :button

    attrs.merge(@html_attributes).compact
  end

  def component_classes
    [
      base_classes,
      variant_classes,
      size_classes,
      @classes
    ].compact.join(" ")
  end

  def base_classes
    [
      "inline-flex items-center justify-center gap-2",
      "whitespace-nowrap rounded-md",
      "text-sm font-medium",
      "transition-all",
      "disabled:pointer-events-none disabled:opacity-50",
      "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
      "aria-invalid:ring-destructive/20 aria-invalid:border-destructive"
    ].join(" ")
  end

  def variant_classes
    case @variant
    when :default
      "bg-primary text-primary-foreground shadow-xs hover:bg-primary/90"
    when :destructive
      "bg-destructive text-white shadow-xs hover:bg-destructive/90 focus-visible:ring-destructive/20"
    when :outline
      "border bg-background shadow-xs hover:bg-accent hover:text-accent-foreground"
    when :secondary
      "bg-secondary text-secondary-foreground shadow-xs hover:bg-secondary/80"
    when :ghost
      "hover:bg-accent hover:text-accent-foreground"
    when :link
      "text-primary underline-offset-4 hover:underline"
    end
  end

  def size_classes
    case @size
    when :default
      "h-9 px-4 py-2 has-[>svg]:px-3"
    when :sm
      "h-8 rounded-md gap-1.5 px-3 has-[>svg]:px-2.5"
    when :lg
      "h-10 rounded-md px-6 has-[>svg]:px-4"
    when :icon
      "size-9"
    when :icon_sm
      "size-8"
    when :icon_lg
      "size-10"
    end
  end
end
