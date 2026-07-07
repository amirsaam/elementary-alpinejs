import Elementary
import Foundation

/// The kind of Alpine.js global to register. Maps to the corresponding `Alpine.GLOBAL` JavaScript method.
public enum AlpineGlobals: String {
    /// `Alpine.data(name, factory)` — registers a reusable component data factory.
    case data
    /// `Alpine.store(name, value)` — registers a global reactive store accessible as `$store.name`.
    case store
    /// `Alpine.bind(name, factory)` — registers a reusable `x-bind` object accessible as `x-bind="name"`.
    case bind
}

/// Emits a `<script>` that fetches a raw JavaScript expression from an
/// external file and registers it as an Alpine.js global (`Alpine.data`,
/// `Alpine.store`, or `Alpine.bind`). The expression is wrapped in a module
/// and loaded via dynamic `import()`, avoiding the need for `eval`/`Function`
/// and keeping the external file free of module boilerplate.
///
/// Use this overload when your registration code lives in a separate `.js`
/// file rather than being inlined in the generated HTML.
///
/// The external file should contain only the raw JavaScript expression (e.g.,
/// a factory arrow function, an object literal, or a function expression) —
/// the same pattern shown in the Alpine.js docs for "Registering from a
/// bundle", adapted for a server-rendered context.
///
/// - Parameters:
///   - kind: Which Alpine.js global API to register under.
///   - on: The name under which to register the global.
///   - src: The URL or path to the external `.js` file.
///
/// **Generated HTML:**
/// ```html
/// <script>
///   document.addEventListener('alpine:init', async () => {
///     const res = await fetch('/js/dropdown.js')
///     const code = await res.text()
///     const blob = new Blob([`export default ${code}`], { type: 'text/javascript' })
///     const url = URL.createObjectURL(blob)
///     const m = await import(url)
///     URL.revokeObjectURL(url)
///     Alpine.data('dropdown', m.default)
///   })
/// </script>
/// ```
///
/// **Example:**
/// ```swift
/// registerGlobal(.data, on: "dropdown", src: "/js/dropdown.js")
/// ```
public func registerGlobal(_ kind: AlpineGlobals, on: String, src: String) -> some HTML {
    let escapedOn = on.replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "'", with: "\\'")
    let body = """
        document.addEventListener('alpine:init', async () => {
            const res = await fetch('\(src)')
            const code = await res.text()
            const blob = new Blob([`export default ${code}`], { type: 'text/javascript' })
            const url = URL.createObjectURL(blob)
            const m = await import(url)
            URL.revokeObjectURL(url)
            Alpine.\(kind.rawValue)('\(escapedOn)', m.default)
        })
        """.trimmingCharacters(in: .newlines)
    return script { HTMLRaw(body) }
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
    let escapedOn = on.replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "'", with: "\\'")
    let body = """
        document.addEventListener('alpine:init', () => {
            Alpine.\(kind.rawValue)('\(escapedOn)', \(action()))
        })
        """.trimmingCharacters(in: .newlines)
    return script { HTMLRaw(body) }
}
