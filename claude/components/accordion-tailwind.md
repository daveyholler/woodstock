# Accordion Component - Tailwind Requirements

## Source
https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/accordion.tsx

---

## Step 2: Non-Standard Tailwind Classes Identified

### Animation Classes
- `animate-accordion-down` - Custom animation for expanding content
- `animate-accordion-up` - Custom animation for collapsing content

### Theme Token Classes
- `text-muted-foreground` - Muted text color for icon
- `border-ring` - Border color using ring token
- `focus-visible:ring-ring/50` - Focus ring color with 50% opacity

### Data-Attribute Selectors
- `data-[state=closed]:animate-accordion-up` - Animation when closing
- `data-[state=open]:animate-accordion-down` - Animation when opening
- `[&[data-state=open]>svg]:rotate-180` - Chevron rotation when open

### Arbitrary Values
- `focus-visible:ring-[3px]` - Custom 3px ring width

---

## Step 3: Categorized Requirements

### A. Required Plugins

| Plugin | Purpose |
|--------|---------|
| tailwindcss-animate | Provides base animation utilities (optional - can define manually) |

### B. Animation Classes

| Class | Purpose | CSS Variable Used | Default Value |
|-------|---------|-------------------|---------------|
| `animate-accordion-down` | Expand content with height animation | `--radix-accordion-content-height` | 0.2s ease-out |
| `animate-accordion-up` | Collapse content with height animation | `--radix-accordion-content-height` | 0.2s ease-out |

### C. Theme Tokens

| Token | CSS Variable | Purpose |
|-------|--------------|---------|
| `muted-foreground` | `--muted-foreground` | Muted text/icon color |
| `ring` | `--ring` | Focus ring color |
| `border` | `--border` | Default border color |

### D. Custom Keyframes

```css
@keyframes accordion-down {
  from {
    height: 0;
  }
  to {
    height: var(--radix-accordion-content-height);
  }
}

@keyframes accordion-up {
  from {
    height: var(--radix-accordion-content-height);
  }
  to {
    height: 0;
  }
}
```

### E. CSS Custom Properties

The following CSS variables are required:

| Variable | Source | Purpose |
|----------|--------|---------|
| `--radix-accordion-content-height` | Radix UI (auto-set) | Dynamic content height for animations |
| `--muted-foreground` | Theme | Color for muted elements |
| `--ring` | Theme | Focus ring color |
| `--border` | Theme | Border color |

---

## Step 4: Configuration Output

### Package Dependencies

```bash
# Optional - only if using tailwindcss-animate plugin
npm install -D tailwindcss-animate
```

### Tailwind v3 Config (tailwind.config.js)

```js
module.exports = {
  theme: {
    extend: {
      colors: {
        border: "hsl(var(--border))",
        ring: "hsl(var(--ring))",
        muted: {
          foreground: "hsl(var(--muted-foreground))",
        },
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [
    // require("tailwindcss-animate"), // optional
  ],
};
```

### Tailwind v4 Config (CSS-based)

```css
@import "tailwindcss";

@theme {
  --color-border: hsl(var(--border));
  --color-ring: hsl(var(--ring));
  --color-muted-foreground: hsl(var(--muted-foreground));

  --animate-accordion-down: accordion-down 0.2s ease-out;
  --animate-accordion-up: accordion-up 0.2s ease-out;
}

@keyframes accordion-down {
  from {
    height: 0;
  }
  to {
    height: var(--radix-accordion-content-height);
  }
}

@keyframes accordion-up {
  from {
    height: var(--radix-accordion-content-height);
  }
  to {
    height: 0;
  }
}
```

### Required CSS Variables

```css
:root {
  /* Border & Ring Colors */
  --border: 220 13% 91%;
  --ring: 224 71% 45%;
  
  /* Muted Colors */
  --muted-foreground: 220 9% 46%;
}

/* Dark mode example */
.dark {
  --border: 217 19% 27%;
  --ring: 224 71% 55%;
  --muted-foreground: 218 11% 65%;
}
```

---

## Animation Reference Table

| Class | Keyframe | CSS Variables | Effect |
|-------|----------|---------------|--------|
| `animate-accordion-down` | `accordion-down` | `--radix-accordion-content-height` | Animates height from 0 to content height over 200ms |
| `animate-accordion-up` | `accordion-up` | `--radix-accordion-content-height` | Animates height from content height to 0 over 200ms |

---

## Theme Token Reference Table

| Utility Class | CSS Variable | Suggested Default (HSL) |
|---------------|--------------|-------------------------|
| `text-muted-foreground` | `--muted-foreground` | `220 9% 46%` |
| `border-ring` | `--ring` | `224 71% 45%` |
| `ring-ring` | `--ring` | `224 71% 45%` |
| `border-b` (uses default) | `--border` | `220 13% 91%` |

---

## Notes for Rails ViewComponent Implementation

Since this is for a Rails app without Radix UI:

1. **Animation Trigger**: The `data-state` attribute must be managed via Stimulus controller
2. **Height Variable**: Without Radix, you'll need JavaScript to set `--radix-accordion-content-height` or use a different animation approach (e.g., `max-height` with fixed values or `grid-template-rows`)
3. **Alternative Animation Approach**:

```css
/* Alternative using CSS grid for accordion animation */
.accordion-content {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 0.2s ease-out;
}

.accordion-content[data-state="open"] {
  grid-template-rows: 1fr;
}

.accordion-content > div {
  overflow: hidden;
}
```
