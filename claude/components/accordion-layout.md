# Accordion Component - Class Analysis

## Source
- **shadcn Registry:** @shadcn/accordion
- **Source URL:** https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/accordion.tsx

## Dependencies
| Package | Purpose |
|---------|---------|
| @radix-ui/react-accordion | Accessible accordion primitives |
| lucide-react | ChevronDownIcon for expand/collapse indicator |

---

## Sub-Components & Tailwind Classes

### 1. Accordion (Root)
No Tailwind classes - uses Radix primitive directly with `data-slot="accordion"`.

---

### 2. AccordionItem

| Class | Category | Purpose |
|-------|----------|---------|
| `border-b` | Border | Adds bottom border to separate items |
| `last:border-b-0` | Border (Modifier) | Removes bottom border from last item |

---

### 3. AccordionHeader (wrapper for Trigger)

| Class | Category | Purpose |
|-------|----------|---------|
| `flex` | Layout | Enables flexbox for header content |

---

### 4. AccordionTrigger

#### Layout Classes
| Class | Purpose |
|-------|---------|
| `flex` | Enables flexbox layout |
| `flex-1` | Allows trigger to grow and fill available space |
| `items-start` | Aligns items to the start (top) of cross-axis |
| `justify-between` | Spaces children to opposite ends |

#### Spacing Classes
| Class | Purpose |
|-------|---------|
| `gap-4` | Adds 1rem gap between children |
| `py-4` | Adds 1rem vertical padding |

#### Typography Classes
| Class | Purpose |
|-------|---------|
| `text-left` | Left-aligns text content |
| `text-sm` | Sets font size to 0.875rem |
| `font-medium` | Sets font weight to 500 |

#### Interactive State Classes
| Class | Purpose |
|-------|---------|
| `rounded-md` | Adds medium border radius for focus ring |
| `transition-all` | Enables smooth transitions for all properties |
| `outline-none` | Removes default browser outline |
| `hover:underline` | Adds underline on hover |
| `disabled:pointer-events-none` | Disables pointer events when disabled |
| `disabled:opacity-50` | Reduces opacity to 50% when disabled |

#### Focus State Classes
| Class | Purpose |
|-------|---------|
| `focus-visible:border-ring` | Applies ring border color on keyboard focus |
| `focus-visible:ring-ring/50` | Applies semi-transparent ring color |
| `focus-visible:ring-[3px]` | Sets focus ring width to 3px |

#### Data Attribute Selectors
| Class | Purpose |
|-------|---------|
| `[&[data-state=open]>svg]:rotate-180` | Rotates chevron icon 180° when accordion is open |

---

### 5. ChevronDownIcon (inside Trigger)

| Class | Category | Purpose |
|-------|----------|---------|
| `text-muted-foreground` | Color | Uses muted foreground color for icon |
| `pointer-events-none` | Interactive | Prevents icon from capturing pointer events |
| `size-4` | Sizing | Sets width and height to 1rem (16px) |
| `shrink-0` | Layout | Prevents icon from shrinking |
| `translate-y-0.5` | Position | Slight vertical offset for alignment |
| `transition-transform` | Animation | Enables smooth transform transitions |
| `duration-200` | Animation | Sets transition duration to 200ms |

---

### 6. AccordionContent

| Class | Category | Purpose |
|-------|----------|---------|
| `overflow-hidden` | Layout | Hides overflow for animation |
| `text-sm` | Typography | Sets font size to 0.875rem |
| `data-[state=closed]:animate-accordion-up` | Animation | Collapses content with upward animation |
| `data-[state=open]:animate-accordion-down` | Animation | Expands content with downward animation |

---

### 7. AccordionContent Inner Div

| Class | Category | Purpose |
|-------|----------|---------|
| `pt-0` | Spacing | No top padding |
| `pb-4` | Spacing | Bottom padding of 1rem |

---

## Custom Animations Required

The following custom keyframe animations must be added to Tailwind config:

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
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
}
```

---

## CSS Custom Properties Used

| Property | Source | Purpose |
|----------|--------|---------|
| `--radix-accordion-content-height` | Radix UI | Dynamic content height for animations |
| `--ring` | Theme | Focus ring color |
| `--muted-foreground` | Theme | Muted text/icon color |

---

## Summary

The accordion component consists of 4 main parts:
1. **Accordion** - Root container (no styles)
2. **AccordionItem** - Individual collapsible sections with bottom borders
3. **AccordionTrigger** - Clickable header with chevron icon that rotates on open
4. **AccordionContent** - Animated content area that expands/collapses

Key features:
- Accessible keyboard navigation via Radix primitives
- Smooth height animations using CSS custom properties
- Focus-visible states for keyboard users
- Disabled state styling
- Responsive chevron rotation indicator
