# Badge API Specification

## Props Interface

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `variant` | `"default" \| "secondary" \| "destructive" \| "outline"` | `"default"` | No | Visual style variant |
| `asChild` | `boolean` | `false` | No | Render as child element using Radix Slot |
| `className` | `string` | - | No | Additional CSS classes |
| `children` | `React.ReactNode` | - | No | Badge content (text, icons, etc.) |
| `...props` | `React.ComponentProps<"span">` | - | No | All standard span HTML attributes |

---

## Sub-components

The Badge is a **single-element component** with no sub-components.

- `Badge` - The only component, renders as a `<span>` element

---

## State Management

The Badge component is **stateless**. It has no internal state management.

- No useState or useReducer hooks
- No open/closed or active/inactive states
- Purely presentational component
- All state is externally controlled via props

---

## Accessibility

### Semantic Markup
- Renders as a `<span>` element by default
- Can be rendered as other elements using `asChild` prop

### Keyboard Interactions
- No specific keyboard interactions (presentational component)
- Inherits focusability if used within interactive context

### Focus Management
- `focus-visible:ring-[3px]` - Shows focus ring on keyboard focus
- `focus-visible:border-ring` - Changes border color on focus
- `focus-visible:ring-ring/50` - Semi-transparent focus ring

### ARIA Support
- `aria-invalid` styling supported for form validation contexts
- No specific ARIA attributes required for basic usage

### Screen Reader Considerations
- Content is read naturally as inline text
- Icons should include appropriate `aria-label` or be marked `aria-hidden`

---

## Data Attributes

The Badge component does **not use any data attributes**.

| Attribute | Values | Purpose |
|-----------|--------|---------|
| N/A | - | No data attributes used |

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `@radix-ui/react-slot` | Latest | Polymorphic rendering via `asChild` prop |

---

## Variant Details

### Default
- Dark background (`bg-primary`)
- Light text (`text-primary-foreground`)
- Hover darkens slightly (`hover:bg-primary/90`)

### Secondary
- Light gray background (`bg-secondary`)
- Dark text (`text-secondary-foreground`)
- Hover slightly darker (`hover:bg-secondary/90`)

### Destructive
- Red/danger background (`bg-destructive`)
- White text
- Special dark mode handling (`dark:bg-destructive/60`)
- Custom focus ring (`focus-visible:ring-destructive/20`)

### Outline
- Transparent/background color (`bg-background`)
- Standard foreground text (`text-foreground`)
- Border visible
- Hover shows accent background (`hover:bg-accent`)

---

## Composition Examples

### Basic Usage

```tsx
import { Badge } from "@/components/ui/badge"

// Default badge
<Badge>New</Badge>

// With variant
<Badge variant="secondary">Draft</Badge>
<Badge variant="destructive">Error</Badge>
<Badge variant="outline">Beta</Badge>
```

### With Icons

```tsx
import { Badge } from "@/components/ui/badge"
import { CheckIcon, AlertCircleIcon } from "lucide-react"

<Badge>
  <CheckIcon />
  Verified
</Badge>

<Badge variant="destructive">
  <AlertCircleIcon />
  Failed
</Badge>
```

### As Counter/Pill

```tsx
<Badge className="h-5 min-w-5 rounded-full px-1 font-mono tabular-nums">
  8
</Badge>

<Badge 
  variant="destructive"
  className="h-5 min-w-5 rounded-full px-1 font-mono tabular-nums"
>
  99+
</Badge>
```

### As Link (using asChild)

```tsx
import { Badge } from "@/components/ui/badge"

<Badge asChild>
  <a href="/docs">Documentation</a>
</Badge>
```

### Custom Colors

```tsx
<Badge 
  variant="secondary"
  className="bg-blue-500 text-white dark:bg-blue-600"
>
  Custom Blue
</Badge>
```

---

## ViewComponent Mapping Notes

### Reserved Keywords
- No conflicts - Badge does not use `content` as a slot name

### Recommended ViewComponent Structure

```ruby
class Ui::Badge < ViewComponent::Base
  VARIANTS = {
    default: "bg-primary text-primary-foreground hover:bg-primary/90",
    secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/90",
    destructive: "bg-destructive text-white hover:bg-destructive/90 ...",
    outline: "text-foreground bg-background hover:bg-accent ..."
  }.freeze

  def initialize(variant: :default, class_name: nil, **attrs)
    @variant = variant
    @class_name = class_name
    @attrs = attrs
  end
end
```

### Content Slot
- Use ViewComponent's native content block for badge text/children
- No need to rename anything - content is passed as block, not slot
