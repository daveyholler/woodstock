# Breadcrumb Component - API & Behavior Documentation

## Component Overview

The Breadcrumb component displays a hierarchical navigation trail showing the user's current location within a site structure. It consists of multiple sub-components that work together.

---

## Component Hierarchy

```
Breadcrumb (root)
└── BreadcrumbList
    └── BreadcrumbItem (repeated)
        ├── BreadcrumbLink (for navigable items)
        ├── BreadcrumbPage (for current page - final item)
        ├── BreadcrumbSeparator (between items)
        └── BreadcrumbEllipsis (optional, for collapsed items)
```

---

## Sub-Component APIs

### 1. Breadcrumb (Root)

**Purpose:** Semantic navigation wrapper

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `classes` | `String` | `nil` | Additional CSS classes |
| `**html_attributes` | `Hash` | `{}` | Additional HTML attributes |

**Rendered Element:** `<nav aria-label="breadcrumb">`

---

### 2. BreadcrumbList

**Purpose:** Container for breadcrumb items

**ViewComponent Approach:** Rendered as part of root template, contains `renders_many :items`

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `classes` | `String` | `nil` | Additional CSS classes |

**Rendered Element:** `<ol>`

---

### 3. BreadcrumbItem

**Purpose:** Individual breadcrumb item wrapper

**ViewComponent Approach:** Slot rendered via `renders_many :items`

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `href` | `String` | `nil` | Link destination (if nil, renders as page) |
| `current` | `Boolean` | `false` | Whether this is the current page |
| `separator` | `Boolean` | `true` | Whether to show separator after this item |
| `classes` | `String` | `nil` | Additional CSS classes |

**Rendered Element:** `<li>` containing either `<a>` or `<span>`

---

### 4. BreadcrumbLink (implicit in Item)

**Purpose:** Clickable navigation link

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `href` | `String` | required | Link destination |
| `classes` | `String` | `nil` | Additional CSS classes |

**Rendered Element:** `<a href="...">`

---

### 5. BreadcrumbPage (implicit in Item)

**Purpose:** Current page indicator (non-clickable)

**Rendered Element:** `<span role="link" aria-disabled="true" aria-current="page">`

---

### 6. BreadcrumbSeparator

**Purpose:** Visual separator between items

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `icon` | `String` | `"chevron-right"` | Lucide icon name for separator |
| `classes` | `String` | `nil` | Additional CSS classes |

**Rendered Element:** `<li role="presentation" aria-hidden="true">`

---

### 7. BreadcrumbEllipsis

**Purpose:** Indicates collapsed/hidden items in long breadcrumb trails

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `classes` | `String` | `nil` | Additional CSS classes |

**Rendered Element:** `<span role="presentation" aria-hidden="true">`

---

## ViewComponent Slot Design

### Recommended Structure

```ruby
class BreadcrumbComponent < ViewComponent::Base
  renders_many :items, "ItemSlot"
  
  class ItemSlot < ViewComponent::Base
    def initialize(href: nil, current: false, separator: true, classes: nil)
      @href = href
      @current = current
      @separator = separator
      @classes = classes
    end
  end
end
```

### Usage Example

```erb
<%= render BreadcrumbComponent.new do |breadcrumb| %>
  <% breadcrumb.with_item(href: "/") do %>Home<% end %>
  <% breadcrumb.with_item(href: "/products") do %>Products<% end %>
  <% breadcrumb.with_item(current: true) do %>Widget<% end %>
<% end %>
```

---

## Accessibility Patterns

### ARIA Attributes

| Element | Attribute | Value | Purpose |
|---------|-----------|-------|---------|
| `<nav>` | `aria-label` | `"breadcrumb"` | Identifies navigation type |
| Current `<span>` | `role` | `"link"` | Semantic role |
| Current `<span>` | `aria-disabled` | `"true"` | Non-interactive |
| Current `<span>` | `aria-current` | `"page"` | Current location |
| Separator `<li>` | `role` | `"presentation"` | Decorative only |
| Separator `<li>` | `aria-hidden` | `"true"` | Hidden from AT |
| Ellipsis `<span>` | `role` | `"presentation"` | Decorative |
| Ellipsis `<span>` | `aria-hidden` | `"true"` | Hidden from AT |

### Screen Reader Support

- Ellipsis includes `<span class="sr-only">More</span>` for context

---

## Keyboard Interactions

| Key | Behavior |
|-----|----------|
| `Tab` | Move focus between links |
| `Enter` | Activate focused link |

**Note:** No special keyboard handling required. Standard link navigation applies.

---

## State Management

**No JavaScript required.** The Breadcrumb component is purely presentational with no interactive state.

---

## Data Attributes

| Attribute | Element | Value | Purpose |
|-----------|---------|-------|---------|
| `data-slot` | Various | `"breadcrumb"`, `"breadcrumb-list"`, `"breadcrumb-item"`, `"breadcrumb-link"`, `"breadcrumb-page"`, `"breadcrumb-separator"`, `"breadcrumb-ellipsis"` | CSS targeting and testing |

---

## Usage Examples

### Basic Breadcrumb

```erb
<%= render BreadcrumbComponent.new do |bc| %>
  <% bc.with_item(href: "/") do %>Home<% end %>
  <% bc.with_item(href: "/docs") do %>Documentation<% end %>
  <% bc.with_item(current: true) do %>Breadcrumb<% end %>
<% end %>
```

### With Custom Separator

```erb
<%= render BreadcrumbComponent.new(separator_icon: "slash") do |bc| %>
  <% bc.with_item(href: "/") do %>Home<% end %>
  <% bc.with_item(current: true) do %>About<% end %>
<% end %>
```

### With Ellipsis (Manual)

```erb
<%= render BreadcrumbComponent.new do |bc| %>
  <% bc.with_item(href: "/") do %>Home<% end %>
  <% bc.with_item(ellipsis: true) do %><% end %>
  <% bc.with_item(href: "/components") do %>Components<% end %>
  <% bc.with_item(current: true) do %>Breadcrumb<% end %>
<% end %>
```

---

## Critical Notes for ViewComponent Implementation

### 1. Avoid `content` Slot Name
Per project conventions, do not use `content` as a slot name. Use `body`, `label`, or direct block content instead.

### 2. Use `classes:` Not `class:`
Ruby keyword conflict - always use `classes:` parameter for custom CSS.

### 3. Separator Logic
- Separator should appear between items, not after the last item
- Can be controlled per-item with `separator: false`

### 4. Current Page Detection
- Last item should typically be the current page
- Can be explicitly set with `current: true`
- Current items render as `<span>` not `<a>`

---

## Stimulus Controller

**Not Required.** The Breadcrumb component has no interactive behavior that requires JavaScript.

If dropdown/ellipsis menu functionality is needed later, it would integrate with a separate DropdownMenu component.
