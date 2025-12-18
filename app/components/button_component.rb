class ButtonComponent < ViewComponent::Base
  renders_one :icon, "IconSlot"
  renders_one :label, "LabelSlot"

  def initialize(class: nil, variant: :primary, size: :sm, icon: nil, icon_side: :left)
    @class = binding.local_variable_get(:class)
    @variant = variant.to_sym
    @size = size.to_sym
    @icon = icon
    @icon_side = icon_side.to_sym
  end

  def size_classes
    case @size
    when :sm then "gap-1.5 h-8 px-3 text-sm"
    when :md then "gap-2 h-10 px-4 text-base"
    when :lg then "gap-2 h-11 px-6 text-lg"
    end
  end

  def icon_name
    @icon
  end

  def icon_size_classes
    case @size
    when :sm then "w-4 h-4"
    when :md then "w-5 h-5"
    when :lg then "w-5 h-5"
    end
  end

  def variant_classes
    case @variant
    when :primary then "btn-primary"
    when :success then "btn-success"
    when :outline then "btn-outline"
    when :ghost then "btn-ghost"
    when :destructive then "btn-destructive"
    end
  end

  def combined_classes
    base = "inline-flex items-center justify-center shadow-sm rounded-md font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none"
    [base, size_classes, variant_classes, icon_order_classes, @class].compact.join(" ")
  end

  def icon_order_classes
    @icon_side == :right ? "flex-row-reverse" : "flex-row"
  end

  class IconSlot < ViewComponent::Base
    def initialize(name:, class: nil, **options)
      @name = name
      @class = binding.local_variable_get(:class)
      @options = options
    end

    def call
      lucide_icon(
        @name,
        class: [@class, "flex-shrink-0"].compact.join(" "),
        **@options
      )
    end
  end

  class LabelSlot < ViewComponent::Base
    def call
      content
    end
  end
end
