# Step 1: Retrieve The Component Classes

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

Save your results to ./claude/components/{COMPONENT_NAME}-layout.md

---

# Step 2: Capture tailwind requirements

Given the shadcn component name "{COMPONENT_NAME}", extract all Tailwind CSS configuration requirements:

## Step 1: Get Component Source

Fetch the component source from:
https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/{COMPONENT_NAME}.tsx

## Step 2: Identify Custom/Non-Standard Tailwind Classes

Scan the source code and identify any classes that are NOT part of default Tailwind CSS, including:

- Animation classes (animate-_, fade-_, zoom-_, slide-_, spin-\*)
- Custom theme tokens (bg-background, text-muted-foreground, border-ring, etc.)
- Data-attribute selectors (data-[state=*]:\*)
- Arbitrary values using brackets (e.g., translate-x-[-50%], max-w-[calc(...)])

## Step 3: Categorize Requirements

### A. Required Plugins

List any Tailwind plugins needed (e.g., tailwindcss-animate) with:

- Package name
- npm install command
- Plugin registration syntax for both Tailwind v3 (JS config) and v4 (CSS config)

### B. Animation Classes

For each animation class used, document:
| Class | Purpose | CSS Variable Set | Default Value |

### C. Theme Tokens

List all semantic color/design tokens used:
| Token | CSS Variable | Purpose |

### D. Custom Keyframes

If the component requires custom @keyframes not provided by a plugin, provide the full keyframe definitions.

### E. CSS Custom Properties

List any CSS variables that must be defined in :root or @theme for the component to work.

## Step 4: Output Format

Provide the output in this structure:

### Package Dependencies

```bash
npm install -D {packages}
```

### Tailwind v3 Config (tailwind.config.js)

```js
module.exports = {
  theme: {
    extend: {
      // any theme extensions needed
    },
  },
  plugins: [
    // required plugins
  ],
};
```

### Tailwind v4 Config (CSS-based)

```css
@import "tailwindcss";
@plugin "{plugin-name}";

@theme {
  /* any custom theme tokens */
}
```

### Required CSS Variables

```css
:root {
  /* list all required CSS custom properties with example values */
}
```

### Animation Reference Table

| Class | Keyframe | CSS Variables | Effect |
| ----- | -------- | ------------- | ------ |

### Theme Token Reference Table

| Utility Class | CSS Variable | Suggested Default

Save your results to ./claude/compoenents/{COMPONENT_NAME}-tailwind.md
