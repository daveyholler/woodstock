# Alert Dialog Tailwind Requirements

## Package Dependencies

```bash
npm install -D tailwindcss-animate
```

## Required Plugins

| Plugin | Purpose |
|--------|---------|
| `tailwindcss-animate` | Provides animate-in, animate-out, fade-*, zoom-* utilities |

---

## Tailwind v3 Config (tailwind.config.js)

```js
module.exports = {
  theme: {
    extend: {
      // Theme tokens are typically defined via CSS variables
    },
  },
  plugins: [
    require("tailwindcss-animate"),
  ],
};
```

---

## Tailwind v4 Config (CSS-based)

```css
@import "tailwindcss";
@plugin "tailwindcss-animate";

@theme {
  /* Animation tokens are provided by tailwindcss-animate */
}
```

---

## Required CSS Variables

```css
:root {
  /* Background colors */
  --background: 0 0% 100%;        /* White background */
  
  /* Text colors */
  --foreground: 0 0% 3.9%;        /* Near-black text */
  --muted-foreground: 0 0% 45.1%; /* Muted gray text */
  
  /* Border colors */
  --border: 0 0% 89.8%;           /* Light gray border */
  
  /* Ring/focus colors */
  --ring: 0 0% 3.9%;              /* Focus ring color */
}

/* Dark mode overrides */
.dark {
  --background: 0 0% 3.9%;
  --foreground: 0 0% 98%;
  --muted-foreground: 0 0% 63.9%;
  --border: 0 0% 14.9%;
  --ring: 0 0% 83.1%;
}
```

---

## Animation Reference Table

| Class | Keyframe | CSS Variables | Effect |
|-------|----------|---------------|--------|
| `animate-in` | enter | `--tw-enter-opacity`, `--tw-enter-scale`, `--tw-enter-translate-x`, `--tw-enter-translate-y` | Base entry animation |
| `animate-out` | exit | `--tw-exit-opacity`, `--tw-exit-scale`, `--tw-exit-translate-x`, `--tw-exit-translate-y` | Base exit animation |
| `fade-in-0` | - | `--tw-enter-opacity: 0` | Fade from 0% opacity |
| `fade-out-0` | - | `--tw-exit-opacity: 0` | Fade to 0% opacity |
| `zoom-in-95` | - | `--tw-enter-scale: 0.95` | Scale from 95% |
| `zoom-out-95` | - | `--tw-exit-scale: 0.95` | Scale to 95% |

---

## Theme Token Reference Table

| Utility Class | CSS Variable | Suggested Default |
|---------------|--------------|-------------------|
| `bg-background` | `--background` | `hsl(0 0% 100%)` |
| `text-muted-foreground` | `--muted-foreground` | `hsl(0 0% 45.1%)` |
| `border` | `--border` | `hsl(0 0% 89.8%)` |

---

## Data Attribute Selectors Used

| Selector | Purpose |
|----------|---------|
| `data-[state=open]:animate-in` | Trigger entry animation when dialog opens |
| `data-[state=closed]:animate-out` | Trigger exit animation when dialog closes |
| `data-[state=closed]:fade-out-0` | Fade to 0 on close |
| `data-[state=open]:fade-in-0` | Fade from 0 on open |
| `data-[state=closed]:zoom-out-95` | Scale to 95% on close |
| `data-[state=open]:zoom-in-95` | Scale from 95% on open |

---

## Arbitrary Values Used

| Class | Purpose |
|-------|---------|
| `top-[50%]` | Position at 50% from top |
| `left-[50%]` | Position at 50% from left |
| `translate-x-[-50%]` | Negative 50% X translation for centering |
| `translate-y-[-50%]` | Negative 50% Y translation for centering |
| `max-w-[calc(100%-2rem)]` | Max width with 1rem margin on each side |
| `bg-black/50` | 50% opacity black for overlay |

---

## Button Variant Dependencies

The `AlertDialogAction` and `AlertDialogCancel` components use `buttonVariants` from the button component:

- `AlertDialogAction`: Uses default button variant
- `AlertDialogCancel`: Uses `variant: "outline"` button variant

Ensure the Button component is available with its variant system.
