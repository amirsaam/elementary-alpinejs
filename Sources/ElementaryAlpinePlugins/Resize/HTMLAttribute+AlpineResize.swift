import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Resize plugin attributes.
    /// See the [Resize plugin docs](https://alpinejs.dev/plugins/resize) for more information.
    public enum xResize {}
}

extension HTMLAttribute.xResize {
    /// Generates an `x-resize` attribute that exposes the element's width and height as `$width` and `$height` magics.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression to run whenever the element's size changes.
    ///   - modifiers: Optional modifiers (e.g., `.document`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-resize="width = $width; height = $height">
    /// <div x-resize.document="width = $width; height = $height">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.xResize.resize("width = $width; height = $height")) {
    ///     p(.x.text("'Width: ' + width + 'px'")) { "" }
    ///     p(.x.text("'Height: ' + height + 'px'")) { "" }
    /// }
    /// div(.xResize.resize("...", modifiers: [.document])) { ... }
    /// ```
    public static func resize(
        _ value: String,
        modifiers: [ResizeModifier] = []
    ) -> HTMLAttribute {
        alpinePluginDirective("x-resize", modifiers: modifiers, value: value)
    }
}
