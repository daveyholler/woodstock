# Step 2a: Generate RSpec Test Suite

**CRITICAL: All tests MUST be written using RSpec. Do not use Minitest or any other testing framework.**

Using the outputs from Steps 1a, 1b, and 1c, generate comprehensive RSpec tests.

## Input Files
- ./claude/components/{COMPONENT_NAME}-layout.md
- ./claude/components/{COMPONENT_NAME}-tailwind.md
- ./claude/components/{COMPONENT_NAME}-api.md

## Test Coverage Requirements

### 1. Rendering Tests
```ruby
RSpec.describe {ComponentName}Component, type: :component do
  describe "rendering" do
    it "renders the root element with correct classes"
    it "renders all required sub-components"
    it "applies custom CSS classes via classes parameter"
    it "forwards HTML attributes to root element"
  end
end
```

### 2. Prop/Slot Tests
For each prop from the API spec:
```ruby
describe "props" do
  it "accepts {prop_name} prop"
  it "applies default value when {prop_name} not provided"
  it "validates {prop_name} type"
end
```

### 3. State & Variant Tests
```ruby
describe "variants" do
  it "applies correct classes for variant={value}"
  it "handles size variants (sm, md, lg)"
  it "handles state data attributes (open, closed, disabled)"
end
```

### 4. Accessibility Tests
```ruby
describe "accessibility" do
  it "includes appropriate ARIA attributes"
  it "has correct role attribute"
  it "includes aria-label when required"
end
```

### 5. Composition Tests
```ruby
describe "composition" do
  it "renders nested content in content slot"
  it "renders trigger in trigger slot"
  it "handles multiple children correctly"
end
```

### 6. Stimulus Controller Tests (if JS needed)
```ruby
describe "stimulus behavior", :js do
  it "initializes stimulus controller"
  it "handles {action} event"
  it "updates state on interaction"
end
```

## Output Format
Generate complete spec file with:
- Proper setup/teardown
- Shared examples for common patterns
- Helper methods for complex setup
- Clear describe/context nesting
- One assertion per test

**IMPORTANT: You must create an actual file using the create_file tool.**

Save to: ./spec/components/{component_name}_component_spec.rb by calling:
```
create_file(path="./spec/components/{component_name}_component_spec.rb", content=<your test code>)
```
