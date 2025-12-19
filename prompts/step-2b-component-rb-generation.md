# Step 2b: Generate ViewComponent Class

Using analysis from Steps 1a-1c, generate the Ruby component class.

## Pattern Requirements

### 1. Follow ViewComponent Conventions

```ruby
# frozen_string_literal: true

class {ComponentName}Component < ApplicationComponent
  # Renders a {component_name} component based on shadcn-ui
  #
  # @example Basic usage
  #   <%= render {ComponentName}Component.new %>
  #
  # @example With variants
  #   <%= render {ComponentName}Component.new(variant: "destructive", size: "lg") %>
end
```

### 2. Props Mapping

Map TypeScript props to Ruby initialize params:

- Use keyword arguments
- Provide sensible defaults
- Add type checking via Sorbet (optional) or runtime checks
- Document each param
- **CRITICAL: Use `classes:` parameter (NOT `class:`) for custom CSS classes**

### 3. CRITICAL: Use `classes:` Parameter (Not `class:`)

**ALWAYS use `classes:` as the parameter name for custom CSS classes.**

❌ WRONG:

```ruby
def initialize(class: nil, **html_attributes)
  @class = binding.local_variable_get(:class)
end
```

✅ CORRECT:

```ruby
def initialize(classes: nil, **html_attributes)
  @classes = classes
end

def component_classes
  class_names(
    base_classes,
    variant_classes,
    state_classes,
    @classes  # User-provided additional classes
  )
end
```

**Rationale:** Avoid Ruby keyword conflicts and unnecessary `binding.local_variable_get` workarounds.

### 6. CRITICAL: ViewComponent Slot Block Execution Patterns

**Problem:** ViewComponent slots have different execution contexts than React components:

- `renders_many :items` slots receive the slot instance, not content directly
- Blocks are executed at definition time, not render time
- Direct content capture patterns from React don't translate

**Solution Patterns:**

❌ WRONG - Direct block capture:

````ruby
def with_item(&block)
  items << capture(&block)
end

✅ CORRECT - Slot instance pattern:
renders_many :items, ->(classes: nil, **attrs) do
  content_tag :div, class: class_names("item-base", classes), **attrs do
    content # Content passed via slot
  end
end

❌ WRONG - Immediate block execution:
# In template
<% component.with_item do %>
  Content here
<% end %>

✅ CORRECT - Slot content pattern:
# In template
<% component.with_item(classes: "custom") do %>
  Content here
<% end %>

When to use lambda slots:
- Complex slot rendering logic
- Dynamic slot behavior based on parameters
- Need to access component instance variables in slot

## Secondary Location: step-2c-erb-template-generation.md

Add this after the existing "CRITICAL: ViewComponent `content` Keyword Conflict" section (around line 28):

```markdown
**CRITICAL: Slot Block Execution Context**
- ViewComponent slots execute blocks differently than React children
- `renders_many` slots receive slot instances, not direct content
- Use proper slot rendering patterns:

```erb
<!-- For renders_one slots -->
<%= trigger if trigger? %>

<!-- For renders_many slots -->
<% items.each do |item| %>
  <%= item %>
<% end %>

<!-- NOT direct block capture -->

### 4. Class Name Builder
Use a consistent pattern for Tailwind class composition:
```ruby
def base_classes
# Core structural classes that are always present
end

def variant_classes
# Classes that change based on props
end

def state_classes
# Classes based on state (disabled, active, etc.)
end

def component_classes
class_names(
  base_classes,
  variant_classes,
  state_classes,
  @classes # User-provided additional classes
)
end
````

### 4. Slots Definition

Define slots for composition:

```ruby
renders_one :trigger
renders_one :content
renders_many :items
```

### 5. Data Attributes

Build data attributes hash:

```ruby
def data_attributes
  {
    controller: stimulus_controller,
    "#{stimulus_controller}-target": "root",
    state: @state,
    # ... other data attributes
  }.compact
end
```

### 6. ViewComponent Patterns

- Use `before_render` for setup if needed
- Implement `call` only if custom rendering needed
- Keep logic out of templates
- Extract complex conditionals to helper methods

## Output Structure

```ruby
# frozen_string_literal: true

class {ComponentName}Component < ApplicationComponent
  # Constants for variants
  VARIANTS = %w[default destructive outline].freeze
  SIZES = %w[sm md lg].freeze

  # Slot definitions
  renders_one :trigger
  renders_one :content

  # Initialize
  def initialize(
    variant: "default",
    size: "md",
    disabled: false,
    classes: nil,
    **html_attributes
  )
    @variant = variant
    @size = size
    @disabled = disabled
    @classes = classes
    @html_attributes = html_attributes

    validate_variant!
  end

  private

  def validate_variant!
    # Validation logic
  end

  def base_classes
    # Base classes
  end

  def variant_classes
    # Variant classes
  end

  def component_classes
    # Class composition
  end

  def data_attributes
    # Data attributes
  end

  def stimulus_controller
    # Return controller name if JS needed
  end
end
```

**IMPORTANT: You must create an actual file using the create_file tool.**

Save to: ./app/components/{component_name}\_component.rb by calling:

```
create_file(path="./app/components/{component_name}_component.rb", content=<your component code>)
```
