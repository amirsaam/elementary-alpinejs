import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Anchor plugin attributes.
    /// See the [Anchor plugin docs](https://alpinejs.dev/plugins/anchor) for more information.
    public enum xAnchor {}
}

extension HTMLAttribute.xAnchor {
    /// Generates an `x-anchor` attribute that positions the element relative to a reference (built on Floating UI).
    ///
    /// - Parameters:
    ///   - value: A reference to the anchor element. Typically `"$refs.NAME"` or a JavaScript expression
    ///     that resolves to an element (e.g., `"document.getElementById('trigger')"`).
    ///   - modifiers: Optional positioning and behavior modifiers (e.g., `.bottomStart`, `.fixed`, `.offset(10)`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-anchor="$refs.button">
    /// <div x-anchor.bottom-start="$refs.button">
    /// <div x-anchor.fixed="$refs.button">
    /// <div x-anchor.offset.10="$refs.button">
    /// <div x-anchor.noflip="$refs.button">
    /// <div x-anchor.no-style="$refs.button">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.show("open"), .xAnchor.anchor("$refs.button")) { "Dropdown" }
    /// div(.x.show("open"), .xAnchor.anchor("$refs.button", modifiers: [.bottomStart])) { "Dropdown" }
    /// div(.x.show("open"), .xAnchor.anchor("$refs.button", modifiers: [.fixed])) { "Dropdown" }
    /// div(.x.show("open"), .xAnchor.anchor("$refs.button", modifiers: [.offset(10)])) { "Dropdown" }
    /// div(.x.show("open"), .xAnchor.anchor("$refs.button", modifiers: [.noflip])) { "Dropdown" }
    /// ```
    public static func anchor(
        _ value: String,
        modifiers: [AnchorModifier] = []
    ) -> HTMLAttribute {
        alpinePluginDirective("x-anchor", modifiers: modifiers, value: value)
    }
}
