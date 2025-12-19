# Step 2c: Generate ERB Template

Generate the HTML template using the class structure from 2b and markup patterns from 1a.

## Template Patterns

### 1. Root Element

```erb
<div class="<%= component_classes %>" <%= tag.attributes(@html_attributes.merge(data: data_attributes)) %>>
  <%# Component content %>
</div>
```

### 2. Slot Rendering

```erb
<% if trigger %>
  <%= trigger %>
<% end %>
```

**CRITICAL: ViewComponent `content` Keyword Conflict**

- ViewComponent reserves `content` as a method name - DO NOT use `content` as a slot name
- If shadcn component has a `content` slot, rename it to: `body`, `main`, `panel`, `inner`, or `children`
- Example: `renders_one :body` instead of `renders_one :content`
- Update ERB template to use the renamed slot: `<%= body %>` instead of `<%= content %>`

### 3. Conditional Rendering

Keep conditionals minimal - push logic to component class:

```erb
<%= content_tag :div, class: trigger_classes, data: trigger_data do %>
  <%= content %>
<% end %>
```

### 4. Maintain Structure from shadcn

Mirror the HTML structure from the TypeScript component:

- Same nesting
- Same element types
- Same class application points

### 5. Best Practices

- No business logic in templates
- Use helper methods from component.rb for complex conditionals
- Keep templates readable and maintainable
- Preserve accessibility attributes
- Match the exact DOM structure from the shadcn source

### 6. CRITICAL: Use Semantic HTML Elements for Their Intended Purpose

**Problem:** Recreating browser-native functionality with divs and CSS classes instead of using proper semantic elements.

**Common Mistakes:**
❌ Using `<div>` + CSS classes for dialogs:
```erb
<div class="<%= dialog_classes %>" data-state="<%= @open ? 'open' : 'closed' %>">
  <!-- Trying to simulate dialog with CSS -->
</div>
```

❌ Manual show/hide with CSS classes instead of native behavior:
```javascript
// Manually managing visibility with classes
element.classList.toggle('hidden')
```

**Correct Approach:**
✅ Use semantic `<dialog>` element:
```erb
<dialog class="<%= component_classes %>" <%= tag.attributes(@html_attributes.merge(data: data_attributes)) %>>
  <%# Dialog content %>
</dialog>
```

✅ Use native dialog methods in Stimulus:
```javascript
// Use browser-native methods
this.element.showModal() // Opens modal dialog
this.element.close()     // Closes dialog
```

**Key Guidelines:**
- **Always check if a semantic HTML element exists** before creating custom solutions
- Native elements provide accessibility, keyboard navigation, and focus management for free
- Common semantic elements to prioritize:
  - `<dialog>` for modals/alerts (not `<div>` with classes)
  - `<button>` for clickable actions (not `<div>` with click handlers)
  - `<details>/<summary>` for collapsible content (not custom accordion divs)
  - `<select>` for dropdowns when appropriate (not custom div dropdowns)

**When to deviate:** Only when the semantic element doesn't provide the exact UX needed AND you can maintain equivalent accessibility.

## Output Format

Generate a clean, well-formatted ERB template that:

- Uses the component class helpers (component_classes, data_attributes, etc.)
- Renders all slots properly
- Maintains semantic HTML
- Includes proper indentation
- Has comments for complex sections

**IMPORTANT: You must create an actual file using the create_file tool.**

Save to: ./app/components/{component_name}\_component.html.erb by calling:

```
create_file(path="./app/components/{component_name}_component.html.erb", content=<your ERB template>)
```
