# Accordion API Specification

## Overview

The Accordion component is built on `@radix-ui/react-accordion` and provides a vertically stacked set of interactive headings that each reveal an associated section of content.

---

## Props Interface

### Accordion (Root)

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `type` | `"single" \| "multiple"` | - | Yes | Determines if one or multiple items can be open simultaneously |
| `value` | `string \| string[]` | - | No | Controlled open item(s). String for single, array for multiple |
| `defaultValue` | `string \| string[]` | - | No | Default open item(s) for uncontrolled usage |
| `onValueChange` | `(value: string \| string[]) => void` | - | No | Callback when open items change |
| `collapsible` | `boolean` | `false` | No | When `type="single"`, allows closing all items |
| `disabled` | `boolean` | `false` | No | Disables all items |
| `orientation` | `"horizontal" \| "vertical"` | `"vertical"` | No | Orientation of the accordion |
| `className` | `string` | - | No | Additional CSS classes |

### AccordionItem

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `value` | `string` | - | Yes | Unique identifier for the item |
| `disabled` | `boolean` | `false` | No | Disables this specific item |
| `className` | `string` | - | No | Additional CSS classes |

### AccordionTrigger

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `children` | `ReactNode` | - | Yes | Trigger label content |
| `className` | `string` | - | No | Additional CSS classes |
| `asChild` | `boolean` | `false` | No | Merge props onto child element |

### AccordionContent

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `children` | `ReactNode` | - | Yes | Content to show when expanded |
| `className` | `string` | - | No | Additional CSS classes (applied to inner div) |
| `forceMount` | `boolean` | `false` | No | Force mount content even when closed |

---

## Sub-components

| shadcn Name | ViewComponent Name | Description |
|-------------|-------------------|-------------|
| `Accordion` | `Accordion` | Root container, manages state |
| `AccordionItem` | `AccordionItem` | Individual collapsible section wrapper |
| `AccordionTrigger` | `AccordionTrigger` | Clickable header that toggles content |
| `AccordionContent` | `AccordionBody` | **RENAMED** - Expandable content area |

> **Note**: `AccordionContent` is renamed to `AccordionBody` in ViewComponent because `content` is a reserved keyword in ViewComponent.

---

## State Management

### States
- **closed** (default): Content is hidden
- **open**: Content is visible and animated in

### Controlled vs Uncontrolled

**Uncontrolled (Recommended for Rails)**
```tsx
<Accordion type="single" collapsible defaultValue="item-1">
  ...
</Accordion>
```

**Controlled**
```tsx
const [value, setValue] = useState("item-1")
<Accordion type="single" value={value} onValueChange={setValue}>
  ...
</Accordion>
```

### Type Modes

| Type | Behavior |
|------|----------|
| `single` | Only one item can be open at a time. Opening another closes the current. |
| `single` + `collapsible` | One item open at a time, but clicking open item closes it |
| `multiple` | Any number of items can be open simultaneously |

---

## Accessibility

### Roles & ARIA Attributes

| Element | Role | ARIA Attributes |
|---------|------|-----------------|
| Accordion | - | - |
| AccordionItem | - | - |
| AccordionTrigger | `button` | `aria-expanded`, `aria-controls` |
| AccordionContent | `region` | `aria-labelledby`, `id` |

### Keyboard Interactions

| Key | Action |
|-----|--------|
| `Space` | Toggle focused item open/closed |
| `Enter` | Toggle focused item open/closed |
| `Tab` | Move focus to next focusable element |
| `Shift+Tab` | Move focus to previous focusable element |
| `ArrowDown` | Move focus to next trigger (vertical orientation) |
| `ArrowUp` | Move focus to previous trigger (vertical orientation) |
| `Home` | Move focus to first trigger |
| `End` | Move focus to last trigger |

### Screen Reader Considerations
- Each trigger announces its expanded/collapsed state
- Content regions are associated with their triggers via `aria-labelledby`
- Disabled items are announced as disabled

---

## Data Attributes

| Attribute | Element | Values | Purpose |
|-----------|---------|--------|---------|
| `data-state` | Item, Trigger, Content | `"open" \| "closed"` | Current open/closed state |
| `data-disabled` | Item, Trigger | `""` (present) or absent | Indicates disabled state |
| `data-orientation` | Root, Item | `"horizontal" \| "vertical"` | Orientation of accordion |
| `data-slot` | All components | Component name | shadcn v4 slot identification |

### CSS Selectors

```css
/* Style based on state */
[data-state="open"] { }
[data-state="closed"] { }

/* Target specific slots */
[data-slot="accordion"] { }
[data-slot="accordion-item"] { }
[data-slot="accordion-trigger"] { }
[data-slot="accordion-content"] { }
```

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `@radix-ui/react-accordion` | ^1.2.0 | Accessible accordion primitives |
| `lucide-react` | ^0.400+ | ChevronDownIcon |

---

## Composition Example

### Basic Usage
```tsx
<Accordion type="single" collapsible>
  <AccordionItem value="item-1">
    <AccordionTrigger>Is it accessible?</AccordionTrigger>
    <AccordionContent>
      Yes. It adheres to the WAI-ARIA design pattern.
    </AccordionContent>
  </AccordionItem>
</Accordion>
```

### Multiple Items Open
```tsx
<Accordion type="multiple" defaultValue={["item-1", "item-2"]}>
  <AccordionItem value="item-1">...</AccordionItem>
  <AccordionItem value="item-2">...</AccordionItem>
  <AccordionItem value="item-3">...</AccordionItem>
</Accordion>
```

### With Default Open Item
```tsx
<Accordion type="single" collapsible defaultValue="item-1">
  <AccordionItem value="item-1">
    <AccordionTrigger>Product Information</AccordionTrigger>
    <AccordionContent>
      <p>Our flagship product...</p>
    </AccordionContent>
  </AccordionItem>
</Accordion>
```

---

## Rails ViewComponent Mapping

### Component Structure
```
AccordionComponent (Root)
├── AccordionItemComponent
│   ├── AccordionTriggerComponent
│   └── AccordionBodyComponent (renamed from Content)
```

### ViewComponent API Translation

| React Pattern | ViewComponent Pattern |
|---------------|----------------------|
| `<Accordion type="single">` | `render AccordionComponent.new(type: :single)` |
| `<AccordionItem value="x">` | `accordion.with_item(value: "x")` |
| Child components via JSX | Slots via `renders_many :items` |
| `className` prop | `class:` or `classes:` argument |
| State via React hooks | State via Stimulus controller |

### Required Stimulus Controller Actions

| Action | Purpose |
|--------|---------|
| `toggle` | Toggle item open/closed state |
| `expand` | Open specific item |
| `collapse` | Close specific item |
| `collapseAll` | Close all items (for single mode) |

---

## Behavior Notes for Rails Implementation

1. **Single vs Multiple Mode**: In single mode, opening an item must close others (handled by Stimulus)
2. **Collapsible**: When false in single mode, one item must always be open
3. **Animation**: Content height animation requires calculating actual content height via JavaScript
4. **Default Value**: Items matching `defaultValue` should render with `data-state="open"` initially
5. **Disabled State**: Must prevent keyboard and pointer interaction
