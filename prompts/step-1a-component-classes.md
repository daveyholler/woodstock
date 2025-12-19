# Step 1a: Retrieve The Component Classes

Given the shadcn component name "{COMPONENT_NAME}", I need you to:

1. First, search for the component in the @shadcn registry using the search_items_in_registries tool with query "{COMPONENT_NAME}"

2. Fetch the component source code from the shadcn GitHub repository at:
   https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/{COMPONENT_NAME}.tsx

3. Parse the source code and provide a detailed breakdown of ALL Tailwind CSS classes used, organized by:
   - Which sub-component/element they belong to (e.g., Wrapper, Trigger, Content, Icon)
   - Grouped by purpose within each element:
     - Layout (flex, grid, positioning)
     - Spacing (padding, margin, gap)
     - Typography (font size, weight, alignment)
     - Colors/Theming (text color, background, border)
     - Interactive States (hover, focus, active, disabled)
     - Animations/Transitions
     - Data-attribute selectors (e.g., [data-state=open])

4. For each class, provide a brief explanation of what it does

5. Note any custom classes or animations that require additional Tailwind config (like custom keyframes)

6. List the component's dependencies (e.g., @radix-ui packages, lucide icons)

Format the output as markdown tables grouped by sub-component for easy scanning.

**IMPORTANT: You must create an actual file using the create_file tool.**

Save your results to ./claude/components/{COMPONENT_NAME}-layout.md by calling:
```
create_file(path="./claude/components/{COMPONENT_NAME}-layout.md", content=<your analysis>)
```
