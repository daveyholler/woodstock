# Button API Specification

## Overview

The shadcn Button is a polymorphic button component built on top of `@radix-ui/react-slot`. It supports multiple visual variants and sizes, and can render as any element using the `asChild` prop.

---

## Props Interface

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `variant` | `"default" \| "destructive" \| "outline" \| "secondary" \| "ghost" \| "link"` | `"default"` | No | Visual style variant |
| `size` | `"default" \| "sm" \| "lg" \| "icon" \| "icon-sm" \| "icon-lg"` | `"default"` | No | Button size |
| `asChild` | `boolean` | `false` | No | Merge props onto child element instead of rendering a button |
| `className` | `string` | - | No | Additional CSS classes |
| `disabled` | `boolean` | `false` | No | Disables the button |
| `type` | `"button" \| "submit" \| "reset"` | `"button"` | No | HTML button type |
| `...props` | `React.ComponentProps<"button">` | - | No | All native button props |

---

## Variant Descriptions

| Variant | Use Case | Visual Style |
|---------|----------|--------------|
| `default` | Primary actions | Solid primary background, high contrast |
| `destructive` | Delete, remove, danger actions | Red/danger background |
| `outline` | Secondary actions, less emphasis | Border with transparent/light background |
| `secondary` | Alternative actions | Muted background |
| `ghost` | Tertiary actions, minimal UI | Transparent, hover reveals background |
| `link` | Navigation, inline actions | Text only with underline on hover |

---

## Size Descriptions

| Size | Dimensions | Use Case |
|------|------------|----------|
| `default` | h-9 (36px), px-4 | Standard buttons |
| `sm` | h-8 (32px), px-3 | Compact UI, toolbars |
| `lg` | h-10 (40px), px-6 | Hero sections, CTAs |
| `icon` | 36x36px square | Icon-only buttons |
| `icon-sm` | 32x32px square | Small icon buttons |
| `icon-lg` | 40x40px square | Large icon buttons |

---

## Sub-components

The Button is a single component with no sub-components. It uses composition via:
- Direct children (text, icons)
- `asChild` prop for polymorphic rendering

---

## State Management

### Internal State
- None. The Button is stateless.

### External State
The button can reflect external state through:
- `disabled` prop
- `aria-disabled` attribute
- `aria-pressed` for toggle buttons
- `aria-expanded` when controlling expandable content

### Controlled Patterns
No controlled/uncontrolled patterns - the button is purely presentational with event handlers.

---

## Accessibility

### ARIA Attributes
| Attribute | Usage |
|-----------|-------|
| `aria-label` | Required for icon-only buttons |
| `aria-disabled` | Mirrors `disabled` prop for screen readers |
| `aria-pressed` | For toggle button patterns |
| `aria-expanded` | When button controls expandable content |
| `aria-haspopup` | When button opens a menu/dialog |
| `aria-invalid` | Styled via CSS when form validation fails |

### Keyboard Interactions
| Key | Action |
|-----|--------|
| `Enter` | Activates the button |
| `Space` | Activates the button |
| `Tab` | Moves focus to/from button |

### Focus Management
- Uses `focus-visible` for keyboard-only focus ring
- Focus ring: 3px ring using `--color-ring` at 50% opacity
- Disabled buttons have `pointer-events: none`

---

## Data Attributes

The Button component does not use custom data attributes. State is communicated via:
- Standard HTML `disabled` attribute
- ARIA attributes
- CSS pseudo-classes (`:hover`, `:focus-visible`, `:disabled`)

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `@radix-ui/react-slot` | ^1.0.0 | Enables `asChild` polymorphic rendering |
| `class-variance-authority` | ^0.7.0 | Manages variant-based styling |

---

## Ref Forwarding

The component forwards refs to the underlying button element:

```tsx
const ref = React.useRef<HTMLButtonElement>(null);
<Button ref={ref}>Click me</Button>
```

When using `asChild`, the ref is forwarded to the child element.

---

## Usage Examples

### Basic Usage

```tsx
<Button>Click me</Button>
```

### With Variants

```tsx
<Button variant="default">Primary</Button>
<Button variant="destructive">Delete</Button>
<Button variant="outline">Cancel</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="ghost">Ghost</Button>
<Button variant="link">Learn more</Button>
```

### With Sizes

```tsx
<Button size="sm">Small</Button>
<Button size="default">Default</Button>
<Button size="lg">Large</Button>
```

### Icon Button

```tsx
<Button size="icon" aria-label="Settings">
  <SettingsIcon />
</Button>
```

### Button with Icon

```tsx
<Button>
  <PlusIcon /> Add Item
</Button>

<Button>
  Download <DownloadIcon />
</Button>
```

### Loading State

```tsx
<Button disabled>
  <Spinner /> Loading...
</Button>
```

### As Link (Polymorphic)

```tsx
<Button asChild>
  <a href="/dashboard">Go to Dashboard</a>
</Button>

// With Next.js Link
<Button asChild>
  <Link href="/login">Login</Link>
</Button>
```

### Disabled State

```tsx
<Button disabled>Can't click me</Button>
```

---

## Ruby/ViewComponent Translation Notes

For the ViewComponent implementation:

1. **Variants and Sizes**: Use Ruby symbols or strings for variant/size props
2. **asChild**: This React-specific pattern won't directly translate. Instead, use a `tag` option to render as different elements
3. **Icons**: Accept icon components as slots or pass icon name strings
4. **Content**: Use a block for button content

### Proposed Ruby API

```erb
<%# Basic %>
<%= render ButtonComponent.new %>

<%# With variant and size %>
<%= render ButtonComponent.new(variant: :destructive, size: :sm) do %>
  Delete
<% end %>

<%# Icon button %>
<%= render ButtonComponent.new(size: :icon, aria_label: "Settings") do %>
  <%= icon("settings") %>
<% end %>

<%# As link %>
<%= render ButtonComponent.new(tag: :a, href: "/dashboard") do %>
  Go to Dashboard
<% end %>
```
