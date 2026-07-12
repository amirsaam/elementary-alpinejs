import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-html` attribute that sets the element's innerHTML reactively.
    ///
    /// - Parameter value: A JavaScript expression whose result is rendered as raw HTML.
    ///   Use with caution — never pass untrusted user input.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-html="richContent"></div>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.html("richContent")) { ... }
    /// ```
    public static func html(_ value: String) -> HTMLAttribute {
        alpineDirective("x-html", value: value)
    }
}
