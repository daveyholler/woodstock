class CardComponent < ViewComponent::Base
  renders_one :title, "TitleSlot"
  renders_one :description, "DescriptionSlot"
  renders_one :action, "ActionSlot"
  renders_one :body, "BodySlot"
  renders_one :footer, "FooterSlot"

  def initialize(class: nil)
    @class = binding.local_variable_get(:class)
  end

  def combined_classes
    base = "bg-background text-foreground flex flex-col gap-6 rounded-xl border border-border py-6 shadow-sm"
    [base, @class].compact.join(" ")
  end

  def has_header?
    title? || description? || action?
  end

  def header_classes
    base = "grid auto-rows-min grid-rows-[auto_auto] items-start gap-1.5 px-6"
    base += " grid-cols-[1fr_auto]" if action?
    base
  end

  class TitleSlot < ViewComponent::Base
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
    end

    def call
      classes = "leading-none font-semibold"
      classes = [classes, @class].compact.join(" ")
      tag.div(content, class: classes, data: { slot: "card-title" })
    end
  end

  class DescriptionSlot < ViewComponent::Base
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
    end

    def call
      classes = "text-muted-foreground text-sm"
      classes = [classes, @class].compact.join(" ")
      tag.div(content, class: classes, data: { slot: "card-description" })
    end
  end

  class ActionSlot < ViewComponent::Base
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
    end

    def call
      classes = "col-start-2 row-span-2 row-start-1 self-start justify-self-end"
      classes = [classes, @class].compact.join(" ")
      tag.div(content, class: classes, data: { slot: "card-action" })
    end
  end

  class BodySlot < ViewComponent::Base
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
    end

    def call
      classes = "px-6"
      classes = [classes, @class].compact.join(" ")
      tag.div(content, class: classes, data: { slot: "card-body" })
    end
  end

  class FooterSlot < ViewComponent::Base
    def initialize(class: nil)
      @class = binding.local_variable_get(:class)
    end

    def call
      classes = "flex items-center px-6"
      classes = [classes, @class].compact.join(" ")
      tag.div(content, class: classes, data: { slot: "card-footer" })
    end
  end
end
