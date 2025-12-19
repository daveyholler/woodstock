# frozen_string_literal: true

class AlertDialogComponent < ViewComponent::Base
  # Renders an alert dialog component based on shadcn-ui
  #
  # Alert dialogs interrupt users with urgent information, details, or actions.
  # Unlike regular dialogs, they require explicit user acknowledgment.
  #
  # @example Basic usage
  #   <%= render AlertDialogComponent.new do |dialog| %>
  #     <% dialog.with_trigger { "Delete Account" } %>
  #     <% dialog.with_body do |body| %>
  #       <% body.with_title { "Are you absolutely sure?" } %>
  #       <% body.with_description { "This action cannot be undone." } %>
  #       <% body.with_cancel { "Cancel" } %>
  #       <% body.with_action { "Delete" } %>
  #     <% end %>
  #   <% end %>
  #
  # @example With destructive action styling
  #   <%= render AlertDialogComponent.new do |dialog| %>
  #     <% dialog.with_trigger { "Delete" } %>
  #     <% dialog.with_body do |body| %>
  #       <% body.with_title { "Delete Item" } %>
  #       <% body.with_description { "Are you sure?" } %>
  #       <% body.with_cancel { "Cancel" } %>
  #       <% body.with_action(classes: "bg-destructive text-white") { "Delete" } %>
  #     <% end %>
  #   <% end %>

  renders_one :trigger, ->(classes: nil, **attrs, &block) {
    TriggerSlot.new(classes: classes, dialog_id: @dialog_id, **attrs, block: block)
  }

  renders_one :body, ->(classes: nil, &block) {
    BodySlot.new(classes: classes, dialog_id: @dialog_id, block: block)
  }

  def initialize(
    classes: nil,
    **html_attributes
  )
    @classes = classes
    @html_attributes = html_attributes
    @dialog_id = "alert-dialog-#{object_id}"
  end

  private

  def component_classes
    class_names(
      "relative",
      @classes
    )
  end

  def data_attributes
    {
      controller: "alert-dialog",
      "alert-dialog-open-value": "false"
    }
  end

  # ==========================================================================
  # TriggerSlot - Button that opens the dialog
  # ==========================================================================

  class TriggerSlot < ViewComponent::Base
    def initialize(classes: nil, dialog_id:, block: nil, **attrs)
      @classes = classes
      @dialog_id = dialog_id
      @block = block
      @attrs = attrs
    end

    def call
      tag.button(
        type: "button",
        class: trigger_classes,
        aria: {
          haspopup: "dialog",
          expanded: "false",
          controls: "#{@dialog_id}-body"
        },
        data: trigger_data_attributes,
        **@attrs
      ) do
        view_context.capture(&@block) if @block
      end
    end

    private

    def trigger_classes
      if @classes.present?
        # If custom classes provided, use only base styles + custom classes
        class_names(
          # Base button styles only
          "inline-flex items-center justify-center gap-2",
          "whitespace-nowrap rounded-md",
          "text-sm font-medium",
          "transition-all",
          "disabled:pointer-events-none disabled:opacity-50",
          "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
          # Size
          "h-9 px-4 py-2",
          @classes
        )
      else
        # Default primary variant when no custom classes
        class_names(
          # Base button styles (matching ButtonComponent default variant)
          "inline-flex items-center justify-center gap-2",
          "whitespace-nowrap rounded-md",
          "text-sm font-medium",
          "transition-all",
          "disabled:pointer-events-none disabled:opacity-50",
          "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
          # Default variant
          "h-9 px-4 py-2",
          "bg-primary text-primary-foreground shadow-xs hover:bg-primary/90"
        )
      end
    end

    def trigger_data_attributes
      {
        slot: "alert-dialog-trigger",
        action: "click->alert-dialog#open"
      }
    end
  end

  # ==========================================================================
  # BodySlot - The dialog content container (renamed from Content)
  # ==========================================================================

  class BodySlot < ViewComponent::Base
    renders_one :title, ->(classes: nil, &block) {
      TitleSlot.new(classes: classes, dialog_id: @dialog_id, block: block)
    }

    renders_one :description, ->(classes: nil, &block) {
      DescriptionSlot.new(classes: classes, dialog_id: @dialog_id, block: block)
    }

    renders_one :cancel, ->(classes: nil, **attrs, &block) {
      CancelSlot.new(classes: classes, **attrs, block: block)
    }

    renders_one :action, ->(classes: nil, **attrs, &block) {
      ActionSlot.new(classes: classes, **attrs, block: block)
    }

    def initialize(classes: nil, dialog_id:, block: nil)
      @classes = classes
      @dialog_id = dialog_id
      @block = block
    end

    def before_render
      @block&.call(self)
    end

    def call
      tag.dialog(
        class: dialog_classes,
        data: dialog_data_attributes,
        aria: {
          labelledby: "#{@dialog_id}-title",
          describedby: description? ? "#{@dialog_id}-description" : nil
        }.compact
        # Explicitly do NOT include any open attribute - dialog should start closed
      ) do
        safe_join([
          render_backdrop,
          render_content
        ])
      end
    end

    private

    def dialog_classes
      class_names(
        # Reset browser dialog styles - make dialog transparent and full viewport
        "p-0 m-0 border-0 max-w-none max-h-none bg-transparent",
        # Positioning - absolute centering like shadcn/ui
        "fixed inset-0",
        # Backdrop styling
        "backdrop:bg-black/50 backdrop:backdrop-blur-sm",
        # Animation/transitions with shadcn/ui classes
        "data-[state=open]:animate-in data-[state=open]:fade-in-0",
        @classes
      )
    end

    def dialog_data_attributes
      {
        "alert-dialog-target": "dialog"
      }
    end

    def content_wrapper_classes
      class_names(
        # Layout & Positioning - shadcn/ui style absolute centering
        "fixed left-[50%] top-[50%] translate-x-[-50%] translate-y-[-50%]",
        "w-full max-w-[calc(100%-2rem)] sm:max-w-lg",
        # Content container styling
        "grid gap-4 p-6",
        # Visual styling
        "bg-background rounded-lg border shadow-lg",
        # Animation classes for zoom effect
        "data-[state=open]:zoom-in-95 data-[state=closed]:zoom-out-95",
        "duration-200",
        # Prevent overflow issues
        "min-w-0"
      )
    end

    def render_header
      tag.div(
        class: header_classes,
        data: { slot: "alert-dialog-header" }
      ) do
        safe_join([
          title,
          description
        ].compact)
      end
    end

    def header_classes
      class_names(
        "flex flex-col gap-2",
        "text-center sm:text-left"
      )
    end

    def render_footer
      return nil unless cancel? || action?

      tag.div(
        class: footer_classes,
        data: { slot: "alert-dialog-footer" }
      ) do
        safe_join([ cancel, action ].compact)
      end
    end

    def footer_classes
      class_names(
        "flex flex-col-reverse gap-2",
        "sm:flex-row sm:justify-end"
      )
    end

    def render_backdrop
      tag.div(
        class: backdrop_classes,
        data: { slot: "alert-dialog-overlay" }
      )
    end

    def backdrop_classes
      class_names(
        "fixed inset-0 bg-black/50",
        "data-[state=open]:animate-in data-[state=open]:fade-in-0",
        "data-[state=closed]:animate-out data-[state=closed]:fade-out-0",
        "data-[state=closed]:duration-300 data-[state=open]:duration-300"
      )
    end

    def render_content
      tag.div(class: content_wrapper_classes) do
        safe_join([
          render_header,
          render_footer
        ].compact)
      end
    end
  end

  # ==========================================================================
  # TitleSlot
  # ==========================================================================

  class TitleSlot < ViewComponent::Base
    def initialize(classes: nil, dialog_id:, block: nil)
      @classes = classes
      @dialog_id = dialog_id
      @block = block
    end

    def call
      tag.h2(
        id: "#{@dialog_id}-title",
        class: title_classes,
        data: { slot: "alert-dialog-title" }
      ) do
        view_context.capture(&@block) if @block
      end
    end

    private

    def title_classes
      class_names(
        "text-lg font-semibold text-foreground",
        @classes
      )
    end
  end

  # ==========================================================================
  # DescriptionSlot
  # ==========================================================================

  class DescriptionSlot < ViewComponent::Base
    def initialize(classes: nil, dialog_id:, block: nil)
      @classes = classes
      @dialog_id = dialog_id
      @block = block
    end

    def call
      tag.p(
        id: "#{@dialog_id}-description",
        class: description_classes,
        data: { slot: "alert-dialog-description" }
      ) do
        view_context.capture(&@block) if @block
      end
    end

    private

    def description_classes
      class_names(
        "text-sm text-muted-foreground",
        @classes
      )
    end
  end

  # ==========================================================================
  # CancelSlot
  # ==========================================================================

  class CancelSlot < ViewComponent::Base
    def initialize(classes: nil, block: nil, **attrs)
      @classes = classes
      @block = block
      @attrs = attrs
    end

    def call
      tag.button(
        type: "button",
        class: cancel_classes,
        data: cancel_data_attributes,
        **@attrs
      ) do
        view_context.capture(&@block) if @block
      end
    end

    private

    def cancel_classes
      class_names(
        # Base button styles
        "inline-flex items-center justify-center gap-2",
        "whitespace-nowrap rounded-md",
        "text-sm font-medium",
        "transition-all",
        "disabled:pointer-events-none disabled:opacity-50",
        "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
        # Outline variant
        "h-9 px-4 py-2",
        "border border-input bg-background text-foreground shadow-xs hover:bg-accent hover:text-accent-foreground",
        @classes
      )
    end

    def cancel_data_attributes
      {
        slot: "alert-dialog-cancel",
        action: "click->alert-dialog#close"
      }
    end
  end

  # ==========================================================================
  # ActionSlot
  # ==========================================================================

  class ActionSlot < ViewComponent::Base
    def initialize(classes: nil, block: nil, **attrs)
      @classes = classes
      @block = block
      @attrs = attrs
    end

    def call
      tag.button(
        type: "button",
        class: action_classes,
        data: action_data_attributes,
        **@attrs
      ) do
        view_context.capture(&@block) if @block
      end
    end

    private

    def action_classes
      if @classes.present?
        # If custom classes provided, use only base styles + custom classes
        class_names(
          # Base button styles only
          "inline-flex items-center justify-center gap-2",
          "whitespace-nowrap rounded-md",
          "text-sm font-medium",
          "transition-all",
          "disabled:pointer-events-none disabled:opacity-50",
          "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
          # Size
          "h-9 px-4 py-2",
          @classes
        )
      else
        # Default primary variant when no custom classes
        class_names(
          # Base button styles
          "inline-flex items-center justify-center gap-2",
          "whitespace-nowrap rounded-md",
          "text-sm font-medium",
          "transition-all",
          "disabled:pointer-events-none disabled:opacity-50",
          "focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px]",
          # Default variant
          "h-9 px-4 py-2",
          "bg-primary text-primary-foreground shadow-xs hover:bg-primary/90"
        )
      end
    end

    def action_data_attributes
      {
        slot: "alert-dialog-action",
        action: "click->alert-dialog#close"
      }
    end
  end
end
