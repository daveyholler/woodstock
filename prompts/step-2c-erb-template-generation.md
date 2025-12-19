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
