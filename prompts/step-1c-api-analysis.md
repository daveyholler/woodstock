# Step 1c: Extract Component API & Behavior Patterns

Given the shadcn component name "{COMPONENT_NAME}":

1. Fetch the component source from:
   https://raw.githubusercontent.com/shadcn-ui/ui/main/apps/v4/registry/new-york-v4/ui/{COMPONENT_NAME}.tsx

2. Analyze and document:

## A. Component Props Interface

Extract TypeScript interface/type definitions:

- Required props
- Optional props
- Prop types and default values
- Callback/event handler signatures

## B. State Management

Identify:

- Internal state (useState, useReducer)
- State transitions (open/closed, active/inactive)
- Controlled vs uncontrolled patterns

## C. Sub-components & Composition

Map the component hierarchy:

- Root component
- Child components (slots/parts)
- How they compose together
- Which parts are required vs optional

**CRITICAL: ViewComponent Reserved Keyword Conflict**

- If shadcn component uses `content` as a slot/sub-component name, it MUST be renamed
- `content` is a reserved keyword in ViewComponent and will cause conflicts
- Rename to alternative like: `body`, `main`, `panel`, `inner`, or `children`
- Document the original shadcn name and the renamed ViewComponent equivalent

## D. Accessibility Patterns

Document:

- ARIA attributes used
- Keyboard interactions
- Focus management
- Role assignments
- Screen reader considerations

## E. Data Attributes & State Selectors

List all data-\* attributes and their possible values:

```
data-state: "open" | "closed"
data-disabled: boolean
data-orientation: "horizontal" | "vertical"
```

## F. Dependencies & Forwarding

- Which Radix primitive is used (if any)
- Prop forwarding patterns
- Ref forwarding

## G. Usage Examples

Extract code examples showing:

- Basic usage
- Composition patterns
- Common variants

## Output Format

````markdown
# {COMPONENT_NAME} API Specification

## Props Interface

| Prop | Type | Default | Required | Description |
| ---- | ---- | ------- | -------- | ----------- |

## Sub-components

- `{Component}.Root` -
- `{Component}.Trigger` -
- `{Component}.Content` -

## State Management

- States: open/closed
- Controlled by: `open` + `onOpenChange`
- Default state: closed

## Accessibility

- Role: dialog
- Keyboard: Esc to close, Tab for focus trap
- ARIA: aria-labelledby, aria-describedby

## Data Attributes

| Attribute | Values | Purpose |
| --------- | ------ | ------- |

## Dependencies

- @radix-ui/react-{primitive}@{version}
- Other dependencies

## Composition Example

```tsx
// Basic usage
// Advanced composition
```
````

```

**IMPORTANT: You must create an actual file using the create_file tool.**

Save to: ./claude/components/{COMPONENT_NAME}-api.md by calling:
```

create_file(path="./claude/components/{COMPONENT_NAME}-api.md", content=<your analysis>)

```

```
