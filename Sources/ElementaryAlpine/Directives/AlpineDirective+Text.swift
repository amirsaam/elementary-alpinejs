import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-text` attribute that sets the element's text content reactively.
    ///
    /// - Parameter value: A JavaScript expression whose result is rendered as text (HTML is escaped).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <span x-text="count"></span>
    /// <p x-text="'Hello, ' + user.name"></p>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// span(.x.text("count")) { "" }
    /// ```
    public static func text(_ value: String) -> HTMLAttribute {
        .init(name: "x-text", value: value)
    }
}
