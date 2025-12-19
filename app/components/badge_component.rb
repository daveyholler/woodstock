# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  # Renders a badge component based on shadcn-ui
  #
  # @example Basic usage
  #   <%= render BadgeComponent.new do %>
  #     New
  #   <% end %>
  #
  # @example With variant
  #   <%= render BadgeComponent.new(variant: :destructive) do %>
  #     Error
  #   <% end %>
  #
  # @example With icon
  #   <%= render BadgeComponent.new(variant: :secondary) do %>
  #     <%= lucide_icon("check") %> Verified
  #   <% end %>
  #
  # @example Counter badge
  #   <%= render BadgeComponent.new(classes: "h-5 min-w-5 px-1 font-mono tabular-nums") do %>
  #     99+
  #   <% end %>

  VARIANTS = %i[default secondary destructive outline].freeze

  def initialize(
    variant: :default,
    classes: nil,
    **html_attributes
  )
    @variant = variant.to_sym
    @classes = classes
    @html_attributes = html_attributes

    validate_variant!
  end

  def call
    content_tag(:span, content, **tag_attributes)
  end

  private

  def validate_variant!
    return if VARIANTS.include?(@variant)

    raise ArgumentError, "Invalid variant: #{@variant}. Must be one of: #{VARIANTS.join(', ')}"
  end

  def tag_attributes
    {
      class: component_classes
    }.merge(@html_attributes).compact
  end

  def component_classes
    [
      base_classes,
      variant_classes,
      @classes
    ].compact.join(" ")
  end

  def base_classes
    [
      "inline-flex items-center justify-center",
      "rounded-full border",
      "px-3 py-0.5",
      "text-xs font-medium",
      "w-fit whitespace-nowrap shrink-0",
      "gap-1",
      "[&>svg]:size-2 [&>svg]:pointer-events-none",
      "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
      "aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive",
      "transition-[color,box-shadow]",
      "overflow-hidden"
    ].join(" ")
  end

  def variant_classes
    case @variant
    when :default
      "border-0 bg-primary text-primary-foreground"
    when :secondary
      "border-0 bg-secondary text-secondary-foreground"
    when :destructive
      [
        "border-0 bg-destructive text-white",
        "focus-visible:ring-destructive/20 dark:focus-visible:ring-destructive/40",
        "dark:bg-destructive/60"
      ].join(" ")
    when :outline
      "text-foreground"
    end
  end
end
