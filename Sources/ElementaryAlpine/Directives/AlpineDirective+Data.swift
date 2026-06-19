import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-data` attribute declaring a component's reactive state.
    ///
    /// - Parameter value: A JavaScript expression that returns the component's initial data object.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-data="{ count: 0 }">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.data("{ count: 0 }")) {
    ///     button(.x.on("click", "count++")) { "Increment" }
    ///     span(.x.text("count")) { "" }
    /// }
    /// ```
    public static func data(_ value: String) -> HTMLAttribute {
        .init(name: "x-data", value: value)
    }
}
