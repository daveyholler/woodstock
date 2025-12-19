# Breadcrumb Component - Tailwind Classes Breakdown

## Source
- shadcn/ui v4 (new-york registry)
- GitHub: `https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/breadcrumb.tsx`

## Dependencies
- `@radix-ui/react-slot` (for asChild pattern - not needed in Rails ViewComponent)
- `lucide-react` icons: `ChevronRight`, `MoreHorizontal`

---

## Sub-Component Class Breakdown

### 1. Breadcrumb (Root)
**Element:** `<nav>`
**Attributes:** `aria-label="breadcrumb"`

| Category | Classes | Purpose |
|----------|---------|---------|
| - | (none) | Wrapper element, no styling |

---

### 2. BreadcrumbList
**Element:** `<ol>`

| Category | Classes | Purpose |
|----------|---------|---------|
| Layout | `flex`, `flex-wrap` | Horizontal layout with wrapping |
| Alignment | `items-center` | Vertically center items |
| Spacing | `gap-1.5`, `sm:gap-2.5` | Gap between items (responsive) |
| Typography | `text-sm` | Small text size |
| Colors | `text-muted-foreground` | Muted text color for non-active items |
| Text | `break-words` | Allow word breaking for long breadcrumbs |

**Combined:** `flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5 text-muted-foreground`

---

### 3. BreadcrumbItem
**Element:** `<li>`

| Category | Classes | Purpose |
|----------|---------|---------|
| Layout | `inline-flex` | Inline flex container |
| Alignment | `items-center` | Vertically center content |
| Spacing | `gap-1.5` | Gap between link and separator |

**Combined:** `inline-flex items-center gap-1.5`

---

### 4. BreadcrumbLink
**Element:** `<a>` (or custom element via asChild)

| Category | Classes | Purpose |
|----------|---------|---------|
| Interactive | `hover:text-foreground` | Darken text on hover |
| Transitions | `transition-colors` | Smooth color transition |

**Combined:** `hover:text-foreground transition-colors`

---

### 5. BreadcrumbPage
**Element:** `<span>`
**Attributes:** `role="link"`, `aria-disabled="true"`, `aria-current="page"`

| Category | Classes | Purpose |
|----------|---------|---------|
| Colors | `text-foreground` | Full foreground color (current page) |
| Typography | `font-normal` | Normal font weight |

**Combined:** `text-foreground font-normal`

---

### 6. BreadcrumbSeparator
**Element:** `<li>`
**Attributes:** `role="presentation"`, `aria-hidden="true"`
**Default Content:** ChevronRight icon

| Category | Classes | Purpose |
|----------|---------|---------|
| Child SVG | `[&>svg]:size-3.5` | Size SVG children to 3.5 (14px) |

**Combined:** `[&>svg]:size-3.5`

---

### 7. BreadcrumbEllipsis
**Element:** `<span>`
**Attributes:** `role="presentation"`, `aria-hidden="true"`
**Content:** MoreHorizontal icon + `<span class="sr-only">More</span>`

| Category | Classes | Purpose |
|----------|---------|---------|
| Layout | `flex` | Flexbox container |
| Sizing | `size-9` | Fixed 36px width/height |
| Alignment | `items-center`, `justify-center` | Center the icon |

**Combined:** `flex size-9 items-center justify-center`

---

## Icon Requirements

| Icon | Package | Usage |
|------|---------|-------|
| `ChevronRight` | lucide-react / lucide-rails | Default separator |
| `MoreHorizontal` | lucide-react / lucide-rails | Ellipsis indicator |

In Rails, use `lucide_icon("chevron-right")` and `lucide_icon("ellipsis")` (or `more-horizontal`).

---

## Summary Table

| Sub-Component | Element | Key Classes |
|---------------|---------|-------------|
| Breadcrumb | `<nav>` | (none) |
| BreadcrumbList | `<ol>` | `flex flex-wrap items-center gap-1.5 sm:gap-2.5 text-sm text-muted-foreground break-words` |
| BreadcrumbItem | `<li>` | `inline-flex items-center gap-1.5` |
| BreadcrumbLink | `<a>` | `hover:text-foreground transition-colors` |
| BreadcrumbPage | `<span>` | `text-foreground font-normal` |
| BreadcrumbSeparator | `<li>` | `[&>svg]:size-3.5` |
| BreadcrumbEllipsis | `<span>` | `flex size-9 items-center justify-center` |
