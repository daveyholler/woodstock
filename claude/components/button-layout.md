# Button Component - Tailwind CSS Class Analysis

## Component Overview

The shadcn Button component is a versatile, polymorphic button that uses `class-variance-authority` (CVA) for managing style variants. It supports rendering as a native `<button>` or any other element via the `asChild` prop using Radix UI's Slot.

## Dependencies

| Package | Purpose |
|---------|---------|
| `@radix-ui/react-slot` | Enables polymorphic rendering via `asChild` prop |
| `class-variance-authority` | Manages variant-based styling |
| `@/lib/utils` (cn) | Utility for merging Tailwind classes |

---

## Base Classes (Applied to All Buttons)

| Class | Category | Purpose |
|-------|----------|---------|
| `inline-flex` | Layout | Makes button an inline flex container |
| `items-center` | Layout | Vertically centers content |
| `justify-center` | Layout | Horizontally centers content |
| `gap-2` | Spacing | 8px gap between child elements (icons, text) |
| `whitespace-nowrap` | Typography | Prevents text wrapping |
| `rounded-md` | Border | Medium border radius (6px) |
| `text-sm` | Typography | Small text size (14px) |
| `font-medium` | Typography | Medium font weight (500) |
| `transition-all` | Animation | Smooth transitions on all properties |
| `disabled:pointer-events-none` | Interactive States | Disables clicks when disabled |
| `disabled:opacity-50` | Interactive States | 50% opacity when disabled |

### Focus States (Base)

| Class | Purpose |
|-------|---------|
| `focus-visible:border-ring` | Shows ring-colored border on keyboard focus |
| `focus-visible:ring-ring/50` | Adds semi-transparent ring on focus |
| `focus-visible:ring-[3px]` | Ring width of 3px |

### Aria Invalid States (Base)

| Class | Purpose |
|-------|---------|
| `aria-invalid:ring-destructive/20` | Red ring when aria-invalid |
| `aria-invalid:border-destructive` | Red border when aria-invalid |

---

## Variant Classes

### Default Variant

| Class | Category | Purpose |
|-------|----------|---------|
| `bg-primary` | Colors | Primary background color |
| `text-primary-foreground` | Colors | Contrasting text color |
| `shadow-xs` | Visual | Extra small shadow |
| `hover:bg-primary/90` | Interactive | 90% opacity on hover |

### Destructive Variant

| Class | Category | Purpose |
|-------|----------|---------|
| `bg-destructive` | Colors | Red/danger background |
| `text-white` | Colors | White text |
| `shadow-xs` | Visual | Extra small shadow |
| `hover:bg-destructive/90` | Interactive | 90% opacity on hover |
| `focus-visible:ring-destructive/20` | Interactive | Red-tinted focus ring |

### Outline Variant

| Class | Category | Purpose |
|-------|----------|---------|
| `border` | Border | Shows border |
| `bg-background` | Colors | Background color |
| `shadow-xs` | Visual | Extra small shadow |
| `hover:bg-accent` | Interactive | Accent background on hover |
| `hover:text-accent-foreground` | Interactive | Accent text color on hover |

### Secondary Variant

| Class | Category | Purpose |
|-------|----------|---------|
| `bg-secondary` | Colors | Secondary background |
| `text-secondary-foreground` | Colors | Secondary text color |
| `shadow-xs` | Visual | Extra small shadow |
| `hover:bg-secondary/80` | Interactive | 80% opacity on hover |

### Ghost Variant

| Class | Category | Purpose |
|-------|----------|---------|
| `hover:bg-accent` | Interactive | Accent background on hover only |
| `hover:text-accent-foreground` | Interactive | Accent text on hover |

### Link Variant

| Class | Category | Purpose |
|-------|----------|---------|
| `text-primary` | Colors | Primary text color |
| `underline-offset-4` | Typography | 4px underline offset |
| `hover:underline` | Interactive | Underline on hover |

---

## Size Classes

### Default Size

| Class | Purpose |
|-------|---------|
| `h-9` | Height of 36px |
| `px-4` | Horizontal padding 16px |
| `py-2` | Vertical padding 8px |
| `has-[>svg]:px-3` | Reduced padding (12px) when containing SVG |

### Small Size (`sm`)

| Class | Purpose |
|-------|---------|
| `h-8` | Height of 32px |
| `rounded-md` | Medium border radius |
| `gap-1.5` | Smaller gap (6px) |
| `px-3` | Horizontal padding 12px |
| `has-[>svg]:px-2.5` | Reduced padding when containing SVG |

### Large Size (`lg`)

| Class | Purpose |
|-------|---------|
| `h-10` | Height of 40px |
| `rounded-md` | Medium border radius |
| `px-6` | Horizontal padding 24px |
| `has-[>svg]:px-4` | Reduced padding when containing SVG |

### Icon Size

| Class | Purpose |
|-------|---------|
| `size-9` | 36px square |

### Icon Small Size (`icon-sm`)

| Class | Purpose |
|-------|---------|
| `size-8` | 32px square |

### Icon Large Size (`icon-lg`)

| Class | Purpose |
|-------|---------|
| `size-10` | 40px square |

---

## CSS Custom Properties Required

The component relies on these CSS variables (typically defined in your Tailwind config or CSS):

| Variable | Usage |
|----------|-------|
| `--primary` | Primary button background |
| `--primary-foreground` | Primary button text |
| `--destructive` | Destructive/danger color |
| `--secondary` | Secondary button background |
| `--secondary-foreground` | Secondary button text |
| `--accent` | Hover state background |
| `--accent-foreground` | Hover state text |
| `--background` | Base background color |
| `--ring` | Focus ring color |

---

## Special Selectors

| Selector | Purpose |
|----------|---------|
| `has-[>svg]:px-*` | Adjusts padding when button contains direct SVG child |
| `disabled:*` | Styles applied when button is disabled |
| `hover:*` | Styles applied on mouse hover |
| `focus-visible:*` | Styles applied on keyboard focus |
| `aria-invalid:*` | Styles applied when aria-invalid attribute is true |

---

## No Custom Keyframes Required

The button component does not require any custom keyframe animations. All transitions use Tailwind's built-in `transition-all` class.
