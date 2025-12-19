# Button Component - Tailwind CSS Requirements

## Overview

The shadcn Button component has minimal custom Tailwind requirements. It primarily uses standard Tailwind utilities and semantic color tokens that need to be defined as CSS custom properties.

---

## Package Dependencies

```bash
# No additional packages required for button
# The component uses only standard Tailwind classes
```

---

## Tailwind v4 Config (CSS-based)

The button component requires these theme tokens to be defined in your Tailwind CSS configuration.

### Required Additions to `application.css`

```css
@theme {
    /* Primary colors - for default button */
    --color-primary: oklch(0.205 0.006 58.254);        /* stone-900 */
    --color-primary-foreground: oklch(0.985 0.001 106.423); /* stone-50 */

    /* Destructive colors - for danger/delete actions */
    --color-destructive: oklch(0.577 0.245 27.325);    /* red-500 */

    /* Secondary colors - for secondary buttons */
    --color-secondary: oklch(0.923 0.003 48.717);      /* stone-200 */
    --color-secondary-foreground: oklch(0.216 0.006 56.043); /* stone-800 */

    /* Accent colors - for ghost/outline hover states */
    --color-accent: oklch(0.923 0.003 48.717);         /* stone-200 */
    --color-accent-foreground: oklch(0.216 0.006 56.043); /* stone-800 */

    /* Extra small shadow for buttons */
    --shadow-xs: 0 1px 2px 0 rgb(0 0 0 / 0.05);
}
```

---

## Required CSS Variables

### Light Mode (already partially defined)

```css
:root {
    /* Existing tokens (already in your config) */
    --color-background: oklch(0.985 0.001 106.423);
    --color-foreground: oklch(0.147 0.004 49.25);
    --color-ring: oklch(0.553 0.013 58.071);

    /* New tokens needed for button */
    --color-primary: oklch(0.205 0.006 58.254);
    --color-primary-foreground: oklch(0.985 0.001 106.423);
    --color-destructive: oklch(0.577 0.245 27.325);
    --color-secondary: oklch(0.923 0.003 48.717);
    --color-secondary-foreground: oklch(0.216 0.006 56.043);
    --color-accent: oklch(0.923 0.003 48.717);
    --color-accent-foreground: oklch(0.216 0.006 56.043);
}
```

### Dark Mode Additions

```css
@media (prefers-color-scheme: dark) {
    :root:not(.light) {
        --color-primary: oklch(0.985 0.001 106.423);        /* stone-50 */
        --color-primary-foreground: oklch(0.205 0.006 58.254); /* stone-900 */
        --color-destructive: oklch(0.577 0.245 27.325);     /* red-500 */
        --color-secondary: oklch(0.268 0.007 34.298);       /* stone-800 */
        --color-secondary-foreground: oklch(0.985 0.001 106.423); /* stone-50 */
        --color-accent: oklch(0.268 0.007 34.298);          /* stone-800 */
        --color-accent-foreground: oklch(0.985 0.001 106.423); /* stone-50 */
    }
}

:root.dark {
    --color-primary: oklch(0.985 0.001 106.423);
    --color-primary-foreground: oklch(0.205 0.006 58.254);
    --color-destructive: oklch(0.577 0.245 27.325);
    --color-secondary: oklch(0.268 0.007 34.298);
    --color-secondary-foreground: oklch(0.985 0.001 106.423);
    --color-accent: oklch(0.268 0.007 34.298);
    --color-accent-foreground: oklch(0.985 0.001 106.423);
}
```

---

## Theme Token Reference Table

| Utility Class | CSS Variable | Light Mode Default | Dark Mode Default |
|---------------|--------------|-------------------|-------------------|
| `bg-primary` | `--color-primary` | stone-900 | stone-50 |
| `text-primary-foreground` | `--color-primary-foreground` | stone-50 | stone-900 |
| `bg-destructive` | `--color-destructive` | red-500 | red-500 |
| `bg-secondary` | `--color-secondary` | stone-200 | stone-800 |
| `text-secondary-foreground` | `--color-secondary-foreground` | stone-800 | stone-50 |
| `bg-accent` | `--color-accent` | stone-200 | stone-800 |
| `text-accent-foreground` | `--color-accent-foreground` | stone-800 | stone-50 |
| `bg-background` | `--color-background` | stone-50 | stone-950 |
| `border-ring` | `--color-ring` | stone-500 | stone-400 |
| `shadow-xs` | `--shadow-xs` | subtle shadow | subtle shadow |

---

## Custom/Non-Standard Classes Used

### Data Attribute Selectors

None required for the button component.

### Arbitrary Values

None required for the button component.

### Special Selectors

| Selector | Purpose | Tailwind Support |
|----------|---------|------------------|
| `has-[>svg]:px-*` | Adjusts padding when button contains SVG | Native Tailwind v3.4+/v4 |
| `disabled:*` | Disabled state styling | Native Tailwind |
| `focus-visible:*` | Keyboard focus styling | Native Tailwind |
| `aria-invalid:*` | Form validation state | Native Tailwind |

---

## Animation Requirements

The button component uses only `transition-all` which is a standard Tailwind utility. No custom keyframes or animations are required.

---

## Plugins Required

None. The button component works with vanilla Tailwind CSS.

---

## Notes on Integration

1. **Existing Setup**: Your `application.css` already defines `--color-background`, `--color-foreground`, `--color-ring`, and shadow utilities. You only need to add the primary, secondary, accent, and destructive color tokens.

2. **Semantic Naming**: The shadcn approach uses semantic color names (primary, secondary, etc.) rather than palette names (blue-600, red-500). This enables easy theming.

3. **Focus Ring**: The component uses `ring-ring/50` which references `--color-ring` with 50% opacity. Your existing `--color-ring` definition will work.

4. **Shadow XS**: You may want to add `--shadow-xs` to your theme for the subtle button shadow, or the component will fall back to no shadow.
