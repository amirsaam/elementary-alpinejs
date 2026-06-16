# ElementaryAlpine: Reactive web apps with Swift

**Ergonomic [AlpineJS](https://alpinejs.dev/) extensions for [Elementary](https://github.com/elementary-swift/elementary)**

```swift
import Elementary
import ElementaryAlpine

// first-class support for all AlpineJS directives
div(.x.data("{ count: 0 }"), .class("counter")) {
    button(.x.on("click", "count++")) { "Increment" }
    span(.x.text("count")) { "0" }
}
```

```swift
// bind attributes reactively
input(.x.bind("placeholder", "text"), .type(.text))

// bind class with object syntax
div(.x.bindClass("{ 'hidden': !open }"))

// bind style with object syntax
div(.x.bindStyle("{ color: 'red' }"))
```

```swift
// event modifiers (passed as a modifiers array)
form(.x.on("submit", "...", modifiers: [.prevent])) {
    button { "Submit" }
}

// keyboard modifiers
input(.x.on("keyup", "submit()", modifiers: [.enter]))

// debounce / throttle (ms)
input(.x.on("input", "fetchResults()", modifiers: [.debounce(500)]))
```

```swift
// two-way binding
input(.x.model("search"))

// model with modifiers
input(.x.model("search", modifiers: [.number, .debounce(300)]))
```

```swift
// loops (semantic name for x-for)
template(.x.loop("item in items")) {
    li(.x.text("item")) { "" }
}

// conditional rendering (semantic name for x-if)
template(.x.when("open")) {
    div { "Content" }
}

// transitions with modifiers
div(.x.show("open"), .x.transition(modifiers: [.scale(80), .origin(.top)])) {
    "Content"
}
```

## Including Alpine.js

This package generates AlpineJS HTML attributes — it does not bundle the Alpine.js runtime. You must include it yourself in your page `<head>`.

This package is built against **Alpine.js v3** (pinned to `3.15.12`).

### From a CDN

```swift
var head: some HTML {
    meta(.charset(.utf8))
    script(.src("https://cdn.jsdelivr.net/npm/alpinejs@3.15.12/dist/cdn.min.js"), .defer) {}
}
```

### From a local file

Download `alpine.min.js` from the [Alpine.js releases](https://github.com/alpinejs/alpine/releases) and place it in your project's `Public/` folder, then reference it:

```swift
var head: some HTML {
    meta(.charset(.utf8))
    script(.src("/alpine.min.js"), .defer) {}
}
```

For Hummingbird/Vapor examples, add the file as a resource in your `Package.swift`:

```swift
.executableTarget(
    name: "App",
    // ...
    resources: [
        .copy("Public")
    ]
)
```

## Modifiers

Directives that support modifiers take a `modifiers:` array parameter with a typed enum value:

```swift
// x-show
.x.show("open", modifiers: [.important])              // → x-show.important="open"

// x-on
.x.on("click", "...", modifiers: [.prevent, .stop])  // → x-on:click.prevent.stop="..."
.x.on("keyup", "...", modifiers: [.enter])            // → x-on:keyup.enter="..."
.x.on("input", "...", modifiers: [.debounce(500)])    // → x-on:input.debounce.500ms="..."
.x.on("click", "...", modifiers: [.selfTarget])       // → x-on:click.self="..."

// x-model
.x.model("search", modifiers: [.number, .change, .blur, .enter])

// x-transition
.x.transition(modifiers: [.opacity])
.x.transition(modifiers: [.scale(80), .origin(.topRight)])
.x.transition(modifiers: [.duration(500), .delay(50)])
```

## Globals

Alpine.js global APIs (`Alpine.data`, `Alpine.store`, `Alpine.bind`) are available as `registerGlobal` for registering reusable components, stores, and bound directives:

```swift
import ElementaryAlpine

// In your head:
registerGlobal(.data, on: "dropdown", action: "() => ({ open: false, toggle() { this.open = !this.open } })")
registerGlobal(.store, on: "notifications", action: "{ items: [] }")
registerGlobal(.bind, on: "myButton", action: "() => ({ type: 'button' })")
```

**Generated HTML:**

```html
<script>document.addEventListener('alpine:init', () => { Alpine.data('dropdown', () => ({ open: false, toggle() { this.open = !this.open } })) })</script>
<script>document.addEventListener('alpine:init', () => { Alpine.store('notifications', { items: [] }) })</script>
<script>document.addEventListener('alpine:init', () => { Alpine.bind('myButton', () => ({ type: 'button' })) })</script>
```

**API:**

| Function | Alpine.js call | Use case |
|----------|---------------|----------|
| `registerGlobal(.data, on:, action:)` | `Alpine.data(name, factory)` | Reusable component data (factory function) |
| `registerGlobal(.store, on:, action:)` | `Alpine.store(name, value)` | Global reactive store (direct object) |
| `registerGlobal(.bind, on:, action:)` | `Alpine.bind(name, factory)` | Reusable x-bind object (factory function) |

## Magics

Alpine.js [magics](https://alpinejs.dev/magics) are JS-side helpers that exist inside Alpine expressions. They don't generate HTML attributes or scripts — they appear as **string literals** in directive values:

```swift
// $dispatch — dispatch a custom event
button(.x.on("click", "$dispatch('notify')")) { "Notify" }

// $store — access a global store
div(.x.text("$store.user.name"))

// $refs — reference an element by key
input(.x.ref("myInput"), .type(.text))
button(.x.on("click", "$refs.myInput.focus()")) { "Focus" }

// $watch — reactively watch a property
div(.x.setup("count = 0; $watch('count', value => console.log(value))"))

// $nextTick — wait for next DOM update
div(.x.setup("$nextTick(() => console.log('mounted')"))

// $el, $root, $data, $id — context accessors
div(.x.data("{ open: false }"), .x.text("$el.tagName"))
```

**Available magics:** `$el`, `$refs`, `$store`, `$watch`, `$dispatch`, `$nextTick`, `$root`, `$data`, `$id`

> No code or attributes are needed for magics — just use the magic name as a string in any Alpine expression.

## Plugins

[Alpine.js plugins](https://alpinejs.dev/plugins) extend the runtime with additional directives. This package ships a separate library, **`ElementaryAlpinePlugins`**, that exposes them as Swift attribute helpers.

> **Alpine.js plugin scripts depend on Alpine.js core.** At the Swift level, `ElementaryAlpinePlugins` has no compile-time dependency on `ElementaryAlpine` — both libraries only depend on `Elementary`. The dependency exists at the **JavaScript runtime** level: plugin CDN scripts hook into the core Alpine instance, so the plugin script tag must be present in your page (and load after Alpine core, per the Alpine.js docs).

### Mask

[Mask](https://alpinejs.dev/plugins/mask) formats text input as the user types. Useful for phone numbers, credit cards, dates, account numbers, etc.

**Add the plugin script to your `<head>` (BEFORE Alpine core, per Alpine.js docs):**

```swift
var head: some HTML {
    meta(.charset(.utf8))
    script(.src("https://cdn.jsdelivr.net/npm/@alpinejs/mask@3.15.12/dist/cdn.min.js"), .defer) {}
    script(.src("https://cdn.jsdelivr.net/npm/alpinejs@3.15.12/dist/cdn.min.js"), .defer) {}
}
```

**Usage:**

```swift
import Elementary
import ElementaryAlpine
import ElementaryAlpinePlugins

// Static pattern — wildcards: 9 (numeric), a (alpha), * (any)
input(.xMask.pattern("99/99/9999"), .x.model("date"))
input(.xMask.pattern("(999) 999-9999"), .x.model("phone"))

// Dynamic mask — expression receives $input
input(.xMask.dynamic("$money($input)"), .x.model("amount"))

// Dynamic mask — function reference
input(.xMask.dynamic("creditCardMask"), .x.model("card"))
```

**Generated HTML:**

```html
<input x-mask="99/99/9999" x-model="date">
<input x-mask="(999) 999-9999" x-model="phone">
<input x-mask:dynamic="$money($input)" x-model="amount">
<input x-mask:dynamic="creditCardMask" x-model="card">
```

**Notes:**
- `x-mask:dynamic` accepts a JavaScript expression or a function name. The expression receives `$input` (the current input value) as a magic.
- The built-in `$money($input, '.', ',', 4)` helper handles currency formatting with optional custom decimal/thousands separators and precision. Pass it as the directive value — no Swift modifier is needed.
- The Mask plugin has **no HTML modifiers** in Alpine.js, so `MaskDynamicModifier` does not exist. All configuration happens in the value string.

## Play with it

Example apps will be added in a future release.

## Documentation

The package ships two libraries:

- **`ElementaryAlpine`** — core:
  - **Attribute helpers** via the `.x` syntax on all `HTMLElements` for all 17 core [AlpineJS directives](https://alpinejs.dev/directives):
    - `x-data`, `x-init` (`.setup`), `x-show`
    - `x-bind` / `x-bind:class` / `x-bind:style`
    - `x-on` with modifiers (base, keyboard, mouse, advanced)
    - `x-text`, `x-html`, `x-model` with modifiers, `x-modelable`
    - `x-for` (`.loop`), `x-transition` (all phases), `x-effect`, `x-ignore`, `x-ref`, `x-cloak`
    - `x-teleport`, `x-if` (`.when`), `x-id`
  - **Global helpers** — `registerGlobal(_:on:action:)` for `Alpine.data()`, `Alpine.store()`, `Alpine.bind()` (see [Globals](#globals))
- **`ElementaryAlpinePlugins`** — Alpine.js plugin wrappers (see [Plugins](#plugins)). Currently ships **Mask** (`.xMask.pattern` / `.xMask.dynamic`).

## Future directions

- Remaining plugin wrappers: Intersect, Resize, Persist, Focus, Collapse, Anchor, Morph, Sort

PRs welcome.

## License

[Apache 2.0](./LICENSE)
