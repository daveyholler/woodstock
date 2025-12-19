# Step 2e: Add Example Usage to Home Page

After generating the ViewComponent, add a usage example to the home page.

## Requirements

1. Open `./app/views/pages/home.html.erb`
2. Add the component example in a dedicated section
3. Include multiple variants to showcase the component's flexibility
4. Add helpful comments explaining the example

## Template Structure

```erb
<!-- {COMPONENT_NAME} Component Examples -->
<section class="space-y-4">
  <h2 class="text-2xl font-bold">
    {ComponentName} Examples
  </h2>

  <!-- Basic Usage -->
  <div class="space-y-2">
    <h3 class="text-lg font-semibold">Basic</h3>
    <%= render {ComponentName}Component.new do %>
      <!-- Component content -->
    <% end %>
  </div>

  <!-- Variants (if applicable) -->
  <div class="space-y-2">
    <h3 class="text-lg font-semibold">Variants</h3>
    <div class="flex gap-4">
      <%= render {ComponentName}Component.new(variant: "default") do %>
        Default
      <% end %>
      <%= render {ComponentName}Component.new(variant: "destructive") do %>
        Destructive
      <% end %>
      <%= render {ComponentName}Component.new(variant: "outline") do %>
        Outline
      <% end %>
    </div>
  </div>

  <!-- Sizes (if applicable) -->
  <div class="space-y-2">
    <h3 class="text-lg font-semibold">Sizes</h3>
    <div class="flex gap-4 items-center">
      <%= render {ComponentName}Component.new(size: "sm") do %>
        Small
      <% end %>
      <%= render {ComponentName}Component.new(size: "md") do %>
        Medium
      <% end %>
      <%= render {ComponentName}Component.new(size: "lg") do %>
        Large
      <% end %>
    </div>
  </div>

  <!-- With Slots (if applicable) -->
  <div class="space-y-2">
    <h3 class="text-lg font-semibold">With Slots</h3>
    <%= render {ComponentName}Component.new do |component| %>
      <% component.with_trigger do %>
        <!-- Trigger content -->
      <% end %>
      <% component.with_content do %>
        <!-- Content slot -->
      <% end %>
    <% end %>
  </div>

  <!-- Custom Classes -->
  <div class="space-y-2">
    <h3 class="text-lg font-semibold">Custom Styling</h3>
    <%= render {ComponentName}Component.new(classes: "border-2 border-purple-500") do %>
      Custom styled
    <% end %>
  </div>
</section>
```

## Instructions

1. Generate examples based on the component's actual API (from Step 1c analysis)
2. Only include sections that are relevant to the component
3. Use realistic content, not just "Lorem ipsum"
4. Ensure examples demonstrate the component's key features
5. Keep examples visually organized with proper spacing

## Output

Append the generated example section to `./app/views/pages/home.html.erb`

**IMPORTANT: Use the str_replace tool to append content to the existing file.**

Read the current content of ./app/views/pages/home.html.erb, then use str_replace to add your examples section at the end.

**Do not replace the entire file - only append the new section.**
