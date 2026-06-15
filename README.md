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

## Play with it

Example apps will be added in a future release.

## Documentation

The package brings the `.x` syntax to all `HTMLElements` — providing a rich API for all 17 core [AlpineJS directives](https://alpinejs.dev/directives):

- `x-data`, `x-init` (`.setup`), `x-show`
- `x-bind` / `x-bind:class` / `x-bind:style`
- `x-on` with modifiers (base, keyboard, mouse, advanced)
- `x-text`, `x-html`, `x-model` with modifiers, `x-modelable`
- `x-for` (`.loop`), `x-transition` (all phases), `x-effect`, `x-ignore`, `x-ref`, `x-cloak`
- `x-teleport`, `x-if` (`.when`), `x-id`

## Future directions

- `Alpine.data()` / `Alpine.store()` / `Alpine.bind()` runtime helpers
- Plugin wrappers (Mask, Intersect, Resize, Persist, Focus, Collapse, Anchor, Morph, Sort)

PRs welcome.

## License

[Apache 2.0](./LICENSE)
