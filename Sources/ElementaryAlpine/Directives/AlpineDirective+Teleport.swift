import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-teleport` attribute that moves the element's children to a different part of the DOM.
    ///
    /// - Parameter value: A CSS selector identifying the destination element.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <template x-teleport="body"><div>Modal</div></template>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// template(.x.teleport("body")) {
    ///     div { "Modal" }
    /// }
    /// ```
    public static func teleport(_ value: String) -> HTMLAttribute<Tag> {
        alpineDirective("x-teleport", value: value)
    }
}
