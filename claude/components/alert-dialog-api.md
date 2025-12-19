# Alert Dialog API Specification

## Overview

AlertDialog is a modal dialog that interrupts the user with important content and expects a response. It's designed for confirmation dialogs, destructive action warnings, and other scenarios requiring explicit user acknowledgment.

---

## Props Interface

### AlertDialog (Root)

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `open` | `boolean` | `undefined` | No | Controlled open state |
| `onOpenChange` | `(open: boolean) => void` | `undefined` | No | Callback when open state changes |
| `defaultOpen` | `boolean` | `false` | No | Initial open state (uncontrolled) |

### AlertDialogTrigger

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `asChild` | `boolean` | `false` | No | Merge props onto child element |

### AlertDialogContent

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `className` | `string` | `undefined` | No | Additional CSS classes |
| `onEscapeKeyDown` | `(event: KeyboardEvent) => void` | `undefined` | No | Called when Escape is pressed |
| `onOpenAutoFocus` | `(event: Event) => void` | `undefined` | No | Called when focus moves into dialog |
| `onCloseAutoFocus` | `(event: Event) => void` | `undefined` | No | Called when focus moves out |
| `forceMount` | `boolean` | `undefined` | No | Force mounting for animation control |

### AlertDialogHeader / AlertDialogFooter

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `className` | `string` | `undefined` | No | Additional CSS classes |
| `...props` | `HTMLDivElement` | - | No | Standard div attributes |

### AlertDialogTitle

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `className` | `string` | `undefined` | No | Additional CSS classes |

### AlertDialogDescription

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `className` | `string` | `undefined` | No | Additional CSS classes |

### AlertDialogAction / AlertDialogCancel

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| `className` | `string` | `undefined` | No | Additional CSS classes |
| `asChild` | `boolean` | `false` | No | Merge props onto child element |

---

## Sub-components

| Component | Radix Primitive | Purpose |
|-----------|-----------------|---------|
| `AlertDialog` | `AlertDialogPrimitive.Root` | Root container, manages state |
| `AlertDialogTrigger` | `AlertDialogPrimitive.Trigger` | Opens the dialog |
| `AlertDialogPortal` | `AlertDialogPrimitive.Portal` | Renders to document.body |
| `AlertDialogOverlay` | `AlertDialogPrimitive.Overlay` | Backdrop overlay |
| `AlertDialogContent` | `AlertDialogPrimitive.Content` | Main content wrapper |
| `AlertDialogHeader` | `div` | Layout wrapper for title/description |
| `AlertDialogFooter` | `div` | Layout wrapper for action buttons |
| `AlertDialogTitle` | `AlertDialogPrimitive.Title` | Dialog title (linked via aria) |
| `AlertDialogDescription` | `AlertDialogPrimitive.Description` | Dialog description (linked via aria) |
| `AlertDialogAction` | `AlertDialogPrimitive.Action` | Confirms action, closes dialog |
| `AlertDialogCancel` | `AlertDialogPrimitive.Cancel` | Cancels action, closes dialog |

---

## State Management

| State | Values | Controlled By | Default |
|-------|--------|---------------|---------|
| `open` | `true` / `false` | `open` + `onOpenChange` props | `false` |

### State Transitions
- **Trigger click** → Opens dialog (`open: true`)
- **Action click** → Closes dialog (`open: false`)
- **Cancel click** → Closes dialog (`open: false`)
- **Escape key** → Closes dialog (`open: false`)
- **Overlay click** → Does NOT close (unlike Dialog)

---

## Accessibility

### ARIA Attributes
| Attribute | Element | Value |
|-----------|---------|-------|
| `role` | Content | `alertdialog` |
| `aria-labelledby` | Content | Links to Title id |
| `aria-describedby` | Content | Links to Description id |

### Keyboard Interactions
| Key | Action |
|-----|--------|
| `Tab` | Move focus within dialog (trapped) |
| `Shift + Tab` | Move focus backwards (trapped) |
| `Escape` | Close dialog, return focus to trigger |
| `Enter` | Activate focused button |
| `Space` | Activate focused button |

### Focus Management
- Focus is trapped within the dialog when open
- Focus moves to first focusable element on open
- Focus returns to trigger element on close
- Cancel button receives initial focus by default

---

## Data Attributes

| Attribute | Element | Values | Purpose |
|-----------|---------|--------|---------|
| `data-state` | Overlay, Content | `"open"` \| `"closed"` | Indicates current state for CSS |

---

## Dependencies

```json
{
  "@radix-ui/react-alert-dialog": "^1.0.0"
}
```

---

## ViewComponent Naming Considerations

**CRITICAL: `content` is a reserved keyword in ViewComponent**

When building the Ruby ViewComponent version:
- `AlertDialogContent` → Rename slot to `body` or `panel`
- The original shadcn name uses `Content`, but ViewComponent reserves this

### Recommended Slot Naming for ViewComponent

| shadcn Name | ViewComponent Slot |
|-------------|-------------------|
| `AlertDialogTrigger` | `trigger` |
| `AlertDialogContent` | `body` (RENAMED) |
| `AlertDialogHeader` | `header` |
| `AlertDialogFooter` | `footer` |
| `AlertDialogTitle` | `title` |
| `AlertDialogDescription` | `description` |
| `AlertDialogAction` | `action` |
| `AlertDialogCancel` | `cancel` |

---

## Composition Examples

### Basic Usage

```tsx
<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="outline">Delete Account</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogHeader>
      <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
      <AlertDialogDescription>
        This action cannot be undone. This will permanently delete your
        account and remove your data from our servers.
      </AlertDialogDescription>
    </AlertDialogHeader>
    <AlertDialogFooter>
      <AlertDialogCancel>Cancel</AlertDialogCancel>
      <AlertDialogAction>Continue</AlertDialogAction>
    </AlertDialogFooter>
  </AlertDialogContent>
</AlertDialog>
```

### Controlled Usage

```tsx
const [open, setOpen] = useState(false)

<AlertDialog open={open} onOpenChange={setOpen}>
  <AlertDialogTrigger asChild>
    <Button>Open</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    {/* ... */}
  </AlertDialogContent>
</AlertDialog>
```

---

## Differences from Dialog

| Feature | Dialog | AlertDialog |
|---------|--------|-------------|
| Close on overlay click | Yes | No |
| Close on Escape | Yes | Yes |
| Role | `dialog` | `alertdialog` |
| Use case | General modals | Confirmations, warnings |
| Required action | Optional | Expected (Action/Cancel) |
