class AvatarComponent < ViewComponent::Base
  renders_one :image, "ImageSlot"
  renders_one :fallback, "FallbackSlot"

  def initialize(class: nil, size: :md)
    @class = binding.local_variable_get(:class)
    @size = size
  end

  def size_classes
    case @size
    when :sm then "h-8 w-8 text-xs"
    when :md then "h-10 w-10 text-sm"
    when :lg then "h-14 w-14 text-lg"
    else "h-10 w-10 text-sm"
    end
  end

  def combined_classes
    base = "relative flex shrink-0 overflow-hidden rounded-full"
    [base, size_classes, @class].compact.join(" ")
  end

  class ImageSlot < ViewComponent::Base
    def initialize(src:, alt: "")
      @src = src
      @alt = alt
    end

    def call
      tag.img(
        src: @src,
        alt: @alt,
        class: "aspect-square h-full w-full object-cover",
        data: {
          avatar_target: "image",
          action: "load->avatar#load error->avatar#error"
        }
      )
    end
  end

  class FallbackSlot < ViewComponent::Base
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
    end

    def call
      classes = "hidden flex h-full w-full items-center justify-center rounded-full bg-muted font-medium"
      classes = [classes, @class].compact.join(" ")
      tag.span(content, class: classes, data: { avatar_target: "fallback" })
    end
  end
end
