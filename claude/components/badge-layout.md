# Badge Component Layout Analysis

## Component Overview

The Badge component is a simple inline element used to display status, labels, or counts. It uses `class-variance-authority` (CVA) for variant management and supports polymorphic rendering via Radix UI's Slot component.

## Dependencies

| Package | Purpose |
|---------|---------|
| `@radix-ui/react-slot` | Polymorphic component rendering (asChild pattern) |

## Sub-Components

The Badge is a single-element component (no sub-components).

---

## Base Element Classes

### Layout

| Class | Purpose |
|-------|---------|
| `inline-flex` | Display as inline flex container |
| `items-center` | Vertically center children |
| `justify-center` | Horizontally center children |
| `w-fit` | Width fits content |
| `shrink-0` | Prevent shrinking in flex containers |

### Spacing

| Class | Purpose |
|-------|---------|
| `px-2` | Horizontal padding (0.5rem / 8px) |
| `py-0.5` | Vertical padding (0.125rem / 2px) |
| `gap-1` | Gap between children (0.25rem / 4px) |

### Typography

| Class | Purpose |
|-------|---------|
| `text-xs` | Extra small text (0.75rem / 12px) |
| `font-medium` | Medium font weight (500) |
| `whitespace-nowrap` | Prevent text wrapping |

### Shape & Border

| Class | Purpose |
|-------|---------|
| `rounded-full` | Fully rounded corners (pill shape) |
| `border` | 1px border |
| `overflow-hidden` | Clip overflowing content |

### Transitions

| Class | Purpose |
|-------|---------|
| `transition-[color,box-shadow]` | Animate color and box-shadow changes |

### Icon Styling (Child Selectors)

| Class | Purpose |
|-------|---------|
| `[&>svg]:size-3` | SVG children sized to 0.75rem (12px) |
| `[&>svg]:pointer-events-none` | Disable pointer events on SVG children |

### Focus States

| Class | Purpose |
|-------|---------|
| `focus-visible:border-ring` | Border color on focus |
| `focus-visible:ring-ring/50` | Ring color at 50% opacity |
| `focus-visible:ring-[3px]` | 3px focus ring |

### Aria Invalid States

| Class | Purpose |
|-------|---------|
| `aria-invalid:ring-destructive/20` | Destructive ring at 20% opacity when invalid |
| `dark:aria-invalid:ring-destructive/40` | Destructive ring at 40% opacity in dark mode |
| `aria-invalid:border-destructive` | Destructive border when invalid |

---

## Variant Classes

### Default Variant

| Class | Purpose |
|-------|---------|
| `bg-primary` | Primary background color |
| `text-primary-foreground` | Primary foreground text color |
| `hover:bg-primary/90` | 90% opacity primary background on hover |

### Secondary Variant

| Class | Purpose |
|-------|---------|
| `bg-secondary` | Secondary background color |
| `text-secondary-foreground` | Secondary foreground text color |
| `hover:bg-secondary/90` | 90% opacity secondary background on hover |

### Destructive Variant

| Class | Purpose |
|-------|---------|
| `bg-destructive` | Destructive background color |
| `text-white` | White text |
| `hover:bg-destructive/90` | 90% opacity destructive background on hover |
| `focus-visible:ring-destructive/20` | Destructive focus ring at 20% opacity |
| `dark:focus-visible:ring-destructive/40` | Destructive focus ring at 40% in dark mode |
| `dark:bg-destructive/60` | 60% opacity destructive background in dark mode |

### Outline Variant

| Class | Purpose |
|-------|---------|
| `text-foreground` | Standard foreground text color |
| `bg-background` | Background color |
| `hover:bg-accent` | Accent background on hover |
| `hover:text-accent-foreground` | Accent foreground text on hover |

---

## Props/API

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `variant` | `"default" \| "secondary" \| "destructive" \| "outline"` | `"default"` | Visual style variant |
| `asChild` | `boolean` | `false` | Render as child element (polymorphic) |
| `className` | `string` | - | Additional CSS classes |
| `...props` | `React.ComponentProps<"span">` | - | Standard span attributes |

---

## Custom Tailwind Configuration Required

None - all classes use standard Tailwind utilities and CSS custom properties defined in the theme.

---

## Usage Examples

```tsx
// Basic
<Badge>Badge</Badge>

// Variants
<Badge variant="secondary">Secondary</Badge>
<Badge variant="destructive">Destructive</Badge>
<Badge variant="outline">Outline</Badge>

// With icon
<Badge variant="secondary">
  <BadgeCheckIcon />
  Verified
</Badge>

// As counter (pill with number)
<Badge className="h-5 min-w-5 rounded-full px-1 font-mono tabular-nums">
  8
</Badge>
```
