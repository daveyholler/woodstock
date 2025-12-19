# Breadcrumb Component - Tailwind Requirements

## Overview
The Breadcrumb component uses primarily standard Tailwind CSS classes. No custom plugins or keyframes are required.

---

## Standard Tailwind Classes Used

All classes used in this component are standard Tailwind CSS v3 utilities:

| Class | Category | Description |
|-------|----------|-------------|
| `flex` | Layout | Flexbox container |
| `flex-wrap` | Layout | Allow items to wrap |
| `inline-flex` | Layout | Inline flexbox |
| `items-center` | Alignment | Vertical centering |
| `justify-center` | Alignment | Horizontal centering |
| `gap-1.5` | Spacing | 6px gap |
| `sm:gap-2.5` | Spacing | 10px gap on sm+ screens |
| `text-sm` | Typography | Small text (14px) |
| `font-normal` | Typography | Normal font weight |
| `break-words` | Typography | Word breaking |
| `size-9` | Sizing | 36px width and height |
| `transition-colors` | Transitions | Color transition |

---

## Theme Tokens Required

The component uses semantic color tokens that must be defined in your Tailwind theme:

| Token | Usage | CSS Variable |
|-------|-------|--------------|
| `text-muted-foreground` | Inactive breadcrumb items | `--muted-foreground` |
| `text-foreground` | Active/current page, hover state | `--foreground` |
| `hover:text-foreground` | Link hover state | `--foreground` |

### Tailwind v3 Config (tailwind.config.js)

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        foreground: "hsl(var(--foreground))",
        "muted-foreground": "hsl(var(--muted-foreground))",
      },
    },
  },
};
```

### CSS Variables (application.css)

```css
:root {
  --foreground: 240 10% 3.9%;
  --muted-foreground: 240 3.8% 46.1%;
}

.dark {
  --foreground: 0 0% 98%;
  --muted-foreground: 240 5% 64.9%;
}
```

---

## Data Attribute Selectors

None required. The Breadcrumb component does not use data-attribute selectors for styling.

---

## Custom Animation Classes

None required. Only `transition-colors` is used for hover state transitions.

---

## Arbitrary Values

None required. All sizing and spacing use standard Tailwind scale values.

---

## Child Selector Classes

| Class | Purpose |
|-------|---------|
| `[&>svg]:size-3.5` | Size SVG children in separator to 14px |

This is a standard Tailwind arbitrary variant and requires no additional configuration.

---

## Required Plugins

**None.** The Breadcrumb component works with vanilla Tailwind CSS v3.

---

## Icon Dependencies

The component uses Lucide icons. In Rails with `lucide-rails` gem:

```ruby
# Gemfile
gem "lucide-rails"
```

```erb
<!-- Separator icon -->
<%= lucide_icon("chevron-right", class: "size-3.5") %>

<!-- Ellipsis icon -->
<%= lucide_icon("ellipsis", class: "size-4") %>
```

---

## Summary

| Requirement | Status |
|-------------|--------|
| Custom plugins | Not required |
| Custom keyframes | Not required |
| Custom animations | Not required |
| Theme tokens | `foreground`, `muted-foreground` (likely already configured) |
| CSS variables | Standard shadcn theme variables |
| Arbitrary values | None |
| Data selectors | None |

**This component has minimal Tailwind requirements and should work out-of-the-box with existing shadcn-style Tailwind configuration.**
