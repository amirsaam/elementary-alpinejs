import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Collapse plugin attributes.
    /// See the [Collapse plugin docs](https://alpinejs.dev/plugins/collapse) for more information.
    public enum xCollapse {}
}

extension HTMLAttribute.xCollapse {
    /// Generates an `x-collapse` attribute that smoothly animates an element's height when `x-show` toggles.
    /// Requires a sibling `x-show` attribute on the same element.
    ///
    /// - Parameter modifiers: Optional modifiers (e.g., `.duration(500)`, `.min(50)`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <p x-show="expanded" x-collapse>
    /// <p x-show="expanded" x-collapse.duration.500ms.min.50px>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// p(.x.show("expanded"), .xCollapse.collapse()) { ... }
    /// p(.x.show("expanded"), .xCollapse.collapse(modifiers: [.duration(1000)])) { ... }
    /// p(.x.show("expanded"), .xCollapse.collapse(modifiers: [.duration(500), .min(50)])) { ... }
    /// ```
    public static func collapse(modifiers: [CollapseModifier] = []) -> HTMLAttribute<Tag> {
        alpinePluginDirective("x-collapse", modifiers: modifiers, value: nil)
    }
}
