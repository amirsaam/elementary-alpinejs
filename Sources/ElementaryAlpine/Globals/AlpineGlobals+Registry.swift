import Elementary

/// The kind of Alpine.js global to register. Maps to the corresponding `Alpine.GLOBAL` JavaScript method.
public enum AlpineGlobals {
    /// `Alpine.data(name, factory)` — registers a reusable component data factory.
    case data
    /// `Alpine.store(name, value)` — registers a global reactive store accessible as `$store.name`.
    case store
    /// `Alpine.bind(name, factory)` — registers a reusable `x-bind` object accessible as `x-bind="name"`.
    case bind
}

/// Emits a `<script>` block that registers an Alpine.js global API (`Alpine.data`, `Alpine.store`, or `Alpine.bind`).
/// The generated script is wrapped in a `document.addEventListener('alpine:init', ...)` handler per the
/// Alpine.js CDN pattern, ensuring the global is registered before Alpine initializes.
///
/// - Parameters:
///   - kind: Which Alpine.js global API to call (`.data`, `.store`, or `.bind`).
///   - on: The name under which to register the global (used as the first argument to the Alpine call).
///   - action: A closure returning a JavaScript expression or object literal to pass as the second argument.
///
/// **Generated HTML (`.data`):**
/// ```html
/// <script>
///   document.addEventListener('alpine:init', () => {
///     Alpine.data('dropdown', () => ({ open: false }))
///   })
/// </script>
/// ```
///
/// **Generated HTML (`.store`):**
/// ```html
/// <script>
///   document.addEventListener('alpine:init', () => {
///     Alpine.store('notifications', { items: [] })
///   })
/// </script>
/// ```
///
/// **Generated HTML (`.bind`):**
/// ```html
/// <script>
///   document.addEventListener('alpine:init', () => {
///     Alpine.bind('myButton', () => ({ type: 'button' }))
///   })
/// </script>
/// ```
///
/// **Example:**
/// ```swift
/// registerGlobal(.data, on: "dropdown") {
///     "() => ({ open: false, toggle() { this.open = !this.open } })"
/// }
/// registerGlobal(.store, on: "notifications") {
///     "{ items: [] }"
/// }
/// registerGlobal(.bind, on: "myButton") {
///     "() => ({ type: 'button' })"
/// }
/// ```
public func registerGlobal(_ kind: AlpineGlobals, on: String, action: () -> String) -> some HTML {
    let method: String
    switch kind {
    case .data: method = "data"
    case .store: method = "store"
    case .bind: method = "bind"
    }
    return script {
        HTMLRaw("document.addEventListener('alpine:init', () => { Alpine.\(method)('\(on)', \(action())) })")
    }
}
