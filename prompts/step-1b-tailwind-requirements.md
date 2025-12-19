# Step 1b: Capture Tailwind Requirements

Given the shadcn component name "{COMPONENT_NAME}", extract all Tailwind CSS configuration requirements:

## Step 1: Get Component Source

Fetch the component source from:
https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/{COMPONENT_NAME}.tsx

## Step 2: Identify Custom/Non-Standard Tailwind Classes

Scan the source code and identify any classes that are NOT part of default Tailwind CSS, including:

- Animation classes (animate-*, fade-*, zoom-*, slide-*, spin-*)
- Custom theme tokens (bg-background, text-muted-foreground, border-ring, etc.)
- Data-attribute selectors (data-[state=*]:*)
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

| Utility Class | CSS Variable | Suggested Default |
| ------------- | ------------ | ----------------- |

**IMPORTANT: You must create an actual file using the create_file tool.**

Save your results to ./claude/components/{COMPONENT_NAME}-tailwind.md by calling:
```
create_file(path="./claude/components/{COMPONENT_NAME}-tailwind.md", content=<your analysis>)
```
