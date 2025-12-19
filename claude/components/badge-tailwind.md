# Badge Component Tailwind Requirements

## Package Dependencies

```bash
npm install -D tailwindcss-animate
```

**Note:** Already installed in this project.

---

## Tailwind v4 Config (CSS-based)

The badge component uses the following theme tokens that are already configured in `app/assets/tailwind/application.css`:

```css
@import "tailwindcss";
@plugin "tailwindcss-animate";

@theme {
    /* Primary colors - for default badge */
    --color-primary: oklch(0.205 0.006 58.254);
    --color-primary-foreground: oklch(0.985 0.001 106.423);

    /* Destructive colors - for destructive badge */
    --color-destructive: oklch(0.577 0.245 27.325);

    /* Secondary colors - for secondary badge */
    --color-secondary: oklch(0.923 0.003 48.717);
    --color-secondary-foreground: oklch(0.216 0.006 56.043);

    /* Accent colors - for outline hover states */
    --color-accent: oklch(0.923 0.003 48.717);
    --color-accent-foreground: oklch(0.216 0.006 56.043);

    /* Semantic colors */
    --color-background: oklch(0.985 0.001 106.423);
    --color-foreground: oklch(0.147 0.004 49.25);
    --color-ring: oklch(0.553 0.013 58.071);
}
```

---

## Required CSS Variables

All required CSS variables are already defined in the project's Tailwind configuration.

| Variable | Light Mode Value | Dark Mode Value | Purpose |
|----------|------------------|-----------------|---------|
| `--color-primary` | stone-900 | stone-50 | Default badge background |
| `--color-primary-foreground` | stone-50 | stone-900 | Default badge text |
| `--color-secondary` | stone-100 | stone-800 | Secondary badge background |
| `--color-secondary-foreground` | stone-900 | stone-50 | Secondary badge text |
| `--color-destructive` | red-600 | red-600/60 | Destructive badge background |
| `--color-accent` | stone-100 | stone-800 | Outline badge hover background |
| `--color-accent-foreground` | stone-900 | stone-50 | Outline badge hover text |
| `--color-background` | stone-50 | stone-950 | Outline badge background |
| `--color-foreground` | stone-950 | stone-50 | Outline badge text |
| `--color-ring` | stone-500 | stone-400 | Focus ring color |

---

## Theme Token Reference Table

| Utility Class | CSS Variable | Purpose |
|--------------|--------------|---------|
| `bg-primary` | `--color-primary` | Default badge background |
| `text-primary-foreground` | `--color-primary-foreground` | Default badge text |
| `bg-secondary` | `--color-secondary` | Secondary badge background |
| `text-secondary-foreground` | `--color-secondary-foreground` | Secondary badge text |
| `bg-destructive` | `--color-destructive` | Destructive badge background |
| `bg-accent` | `--color-accent` | Outline hover background |
| `text-accent-foreground` | `--color-accent-foreground` | Outline hover text |
| `bg-background` | `--color-background` | Outline badge background |
| `text-foreground` | `--color-foreground` | Outline badge text |
| `border-ring` | `--color-ring` | Focus state border |
| `ring-ring` | `--color-ring` | Focus ring color |

---

## Animation Reference Table

The badge component does not require any animations or custom keyframes.

---

## Additional Notes

1. **No Custom Animations**: The badge only uses `transition-[color,box-shadow]` for smooth hover/focus state changes, which is built into Tailwind.

2. **Focus Ring Utilities**: The component uses Tailwind's built-in ring utilities with the semantic `ring` color token.

3. **Arbitrary Values**: The component uses `focus-visible:ring-[3px]` for precise focus ring width.

4. **Modifier Classes Used**:
   - `hover:` - Hover state styles
   - `focus-visible:` - Keyboard focus styles
   - `dark:` - Dark mode overrides
   - `aria-invalid:` - Invalid state styles

5. **Child Selectors**: The component uses `[&>svg]:size-3` and `[&>svg]:pointer-events-none` for icon styling.
