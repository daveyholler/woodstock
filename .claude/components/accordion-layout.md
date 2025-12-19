# Accordion Component - Tailwind CSS Class Breakdown

Source: [shadcn/ui accordion](https://github.com/shadcn-ui/ui/blob/main/apps/v4/registry/new-york-v4/ui/accordion.tsx)

## Dependencies

| Package | Purpose |
|---------|---------|
| `@radix-ui/react-accordion` | React primitive (replaced with Stimulus in Rails) |
| `lucide-react` | Icons (`lucide-rails` gem in Rails) |

---

## Sub-Components

### 1. Accordion (Root Wrapper)

| Class | Purpose | Category |
|-------|---------|----------|
| `w-full` | Full width container | Layout |

**Data Attributes:**
- `data-slot="accordion"` - Styling hook

---

### 2. AccordionItem

| Class | Purpose | Category |
|-------|---------|----------|
| `border-b` | Bottom border separator | Border |
| `last:border-b-0` | Remove border from last item | Border (Modifier) |

**Data Attributes:**
- `data-slot="accordion-item"` - Styling hook

---

### 3. AccordionTrigger (Header Button)

#### Layout Classes
| Class | Purpose |
|-------|---------|
| `flex` | Flexbox container |
| `flex-1` | Fill available space |
| `items-center` | Vertical center alignment |
| `justify-between` | Space between text and icon |

#### Spacing Classes
| Class | Purpose |
|-------|---------|
| `gap-4` | Gap between content and chevron |
| `py-4` | Vertical padding (16px top/bottom) |

#### Typography Classes
| Class | Purpose |
|-------|---------|
| `text-left` | Left-align text |
| `text-sm` | Small text size (14px) |
| `font-medium` | Medium font weight (500) |

#### Interactive State Classes
| Class | Purpose |
|-------|---------|
| `hover:underline` | Underline on hover |

#### Focus State Classes
| Class | Purpose |
|-------|---------|
| `focus-visible:outline-none` | Remove default outline |
| `focus-visible:ring-1` | 1px focus ring |
| `focus-visible:ring-ring` | Ring uses semantic color token |

#### Disabled State Classes
| Class | Purpose |
|-------|---------|
| `disabled:pointer-events-none` | Disable mouse interactions |
| `disabled:opacity-50` | 50% opacity when disabled |

#### Animation Classes
| Class | Purpose |
|-------|---------|
| `[&[data-state=open]>svg]:rotate-180` | Rotate chevron 180° when open |

**Data Attributes:**
- `data-slot="accordion-trigger"` - Styling hook
- `data-state="open|closed"` - Current state

---

### 4. Chevron Icon

| Class | Purpose | Category |
|-------|---------|----------|
| `size-4` | 16px width/height | Sizing |
| `shrink-0` | Prevent flex shrinking | Layout |
| `text-muted-foreground` | Muted color token | Colors |
| `transition-transform` | Smooth transform transitions | Animation |
| `duration-200` | 200ms transition duration | Animation |
| `pointer-events-none` | Prevent icon click events | Interactive |

---

### 5. AccordionContent (Collapsible Section)

| Class | Purpose | Category |
|-------|---------|----------|
| `overflow-hidden` | Hide overflow during animation | Layout |
| `text-sm` | Small text size (14px) | Typography |

#### Animation Classes
| Class | Purpose |
|-------|---------|
| `data-[state=closed]:animate-accordion-up` | Collapse animation |
| `data-[state=open]:animate-accordion-down` | Expand animation |

**Data Attributes:**
- `data-slot="accordion-content"` - Styling hook
- `data-state="open|closed"` - Current state

---

### 6. Content Inner Wrapper

| Class | Purpose | Category |
|-------|---------|----------|
| `pb-4` | Bottom padding (16px) | Spacing |
| `pt-0` | No top padding | Spacing |

---

## Required Tailwind Configuration

### Animation Keyframes

Add to `app/assets/tailwind/application.css` in the `@theme` block:

```css
@theme {
  --animate-accordion-down: accordion-down 0.2s ease-out;
  --animate-accordion-up: accordion-up 0.2s ease-out;
}

@keyframes accordion-down {
  from { height: 0; }
  to { height: var(--accordion-content-height); }
}

@keyframes accordion-up {
  from { height: var(--accordion-content-height); }
  to { height: 0; }
}
```

**Note:** The `--accordion-content-height` CSS custom property is set dynamically via JavaScript (Stimulus controller) using the element's `scrollHeight`.

---

## Complete Class Summary by Element

```
Accordion (root)
└── w-full

AccordionItem
└── border-b last:border-b-0

AccordionTrigger
└── flex flex-1 items-center justify-between gap-4 py-4
    text-left text-sm font-medium
    hover:underline
    focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring
    disabled:pointer-events-none disabled:opacity-50
    [&[data-state=open]>svg]:rotate-180

Chevron Icon
└── size-4 shrink-0 text-muted-foreground
    transition-transform duration-200 pointer-events-none

AccordionContent
└── overflow-hidden text-sm
    data-[state=closed]:animate-accordion-up
    data-[state=open]:animate-accordion-down

Content Inner
└── pb-4 pt-0
```
