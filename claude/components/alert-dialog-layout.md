# Alert Dialog Component Layout Analysis

## Dependencies

- `@radix-ui/react-alert-dialog` - Core primitive
- `@/lib/utils` - cn() utility function
- `@/registry/new-york-v4/ui/button` - buttonVariants for action buttons

## Sub-components

1. `AlertDialog` - Root wrapper (re-export of Radix primitive)
2. `AlertDialogTrigger` - Opens dialog (re-export of Radix primitive)
3. `AlertDialogPortal` - Portal container (re-export of Radix primitive)
4. `AlertDialogOverlay` - Backdrop overlay
5. `AlertDialogContent` - Main content container
6. `AlertDialogHeader` - Header section
7. `AlertDialogFooter` - Footer section
8. `AlertDialogTitle` - Title text
9. `AlertDialogDescription` - Description text
10. `AlertDialogAction` - Primary action button
11. `AlertDialogCancel` - Cancel button (outline style)

---

## AlertDialogOverlay Classes

| Class | Category | Purpose |
|-------|----------|---------|
| `fixed` | Layout | Position fixed to viewport |
| `inset-0` | Layout | Full viewport coverage (top/right/bottom/left: 0) |
| `z-50` | Layout | High z-index for layering |
| `bg-black/50` | Colors | Semi-transparent black backdrop |
| `data-[state=open]:animate-in` | Animation | Entry animation when open |
| `data-[state=closed]:animate-out` | Animation | Exit animation when closing |
| `data-[state=closed]:fade-out-0` | Animation | Fade out to 0 opacity |
| `data-[state=open]:fade-in-0` | Animation | Fade in from 0 opacity |

---

## AlertDialogContent Classes

| Class | Category | Purpose |
|-------|----------|---------|
| `fixed` | Layout | Position fixed to viewport |
| `top-[50%]` | Layout | Center vertically (50% from top) |
| `left-[50%]` | Layout | Center horizontally (50% from left) |
| `translate-x-[-50%]` | Layout | Offset by -50% width for true centering |
| `translate-y-[-50%]` | Layout | Offset by -50% height for true centering |
| `z-50` | Layout | High z-index for layering |
| `grid` | Layout | Grid display for content |
| `w-full` | Layout | Full width |
| `max-w-[calc(100%-2rem)]` | Layout | Max width with 1rem margin on each side |
| `sm:max-w-lg` | Layout | Max width of lg (32rem) on sm+ screens |
| `gap-4` | Spacing | 1rem gap between grid items |
| `p-6` | Spacing | 1.5rem padding |
| `rounded-lg` | Styling | Large border radius |
| `border` | Styling | Default border |
| `shadow-lg` | Styling | Large shadow |
| `bg-background` | Colors | Background color token |
| `duration-200` | Animation | 200ms transition duration |
| `data-[state=open]:animate-in` | Animation | Entry animation when open |
| `data-[state=closed]:animate-out` | Animation | Exit animation when closing |
| `data-[state=closed]:fade-out-0` | Animation | Fade out to 0 opacity |
| `data-[state=open]:fade-in-0` | Animation | Fade in from 0 opacity |
| `data-[state=closed]:zoom-out-95` | Animation | Scale down to 95% when closing |
| `data-[state=open]:zoom-in-95` | Animation | Scale up from 95% when opening |

---

## AlertDialogHeader Classes

| Class | Category | Purpose |
|-------|----------|---------|
| `flex` | Layout | Flexbox container |
| `flex-col` | Layout | Column direction |
| `gap-2` | Spacing | 0.5rem gap |
| `text-center` | Typography | Center text (mobile default) |
| `sm:text-left` | Typography | Left-align text on sm+ screens |

---

## AlertDialogFooter Classes

| Class | Category | Purpose |
|-------|----------|---------|
| `flex` | Layout | Flexbox container |
| `flex-col-reverse` | Layout | Column reverse (Cancel below Action on mobile) |
| `gap-2` | Spacing | 0.5rem gap |
| `sm:flex-row` | Layout | Row direction on sm+ screens |
| `sm:justify-end` | Layout | Right-align buttons on sm+ screens |

---

## AlertDialogTitle Classes

| Class | Category | Purpose |
|-------|----------|---------|
| `text-lg` | Typography | Large text size (1.125rem) |
| `font-semibold` | Typography | Semi-bold font weight |

---

## AlertDialogDescription Classes

| Class | Category | Purpose |
|-------|----------|---------|
| `text-sm` | Typography | Small text size (0.875rem) |
| `text-muted-foreground` | Colors | Muted text color token |

---

## AlertDialogAction Classes

| Class | Category | Purpose |
|-------|----------|---------|
| Uses `buttonVariants()` | Button | Default button variant styles |

---

## AlertDialogCancel Classes

| Class | Category | Purpose |
|-------|----------|---------|
| Uses `buttonVariants({ variant: "outline" })` | Button | Outline button variant |

---

## Custom Animations Required

The following animations require `tailwindcss-animate` plugin:

| Animation Class | Keyframe | Effect |
|-----------------|----------|--------|
| `animate-in` | Entry animation | Base class for enter animations |
| `animate-out` | Exit animation | Base class for exit animations |
| `fade-in-0` | fadeIn | Fade from opacity 0 |
| `fade-out-0` | fadeOut | Fade to opacity 0 |
| `zoom-in-95` | zoomIn | Scale from 95% |
| `zoom-out-95` | zoomOut | Scale to 95% |

## Theme Tokens Required

| Token | CSS Variable | Purpose |
|-------|--------------|---------|
| `bg-background` | `--background` | Dialog background color |
| `text-muted-foreground` | `--muted-foreground` | Description text color |
| `border` | `--border` | Border color |
