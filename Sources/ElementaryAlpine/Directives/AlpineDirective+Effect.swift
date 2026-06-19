import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-effect` attribute that re-runs a JavaScript expression whenever its dependencies change.
    ///
    /// - Parameter value: A JavaScript expression to re-run reactively.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-effect="console.log(count)"></div>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.effect("console.log(count)")) { ... }
    /// ```
    public static func effect(_ value: String) -> HTMLAttribute {
        .init(name: "x-effect", value: value)
    }
}
