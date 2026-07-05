import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-init` attribute that runs a JavaScript expression when the element is initialized.
    ///
    /// - Parameter value: A JavaScript expression to run on initialization.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-init="console.log('mounted')">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.setup("console.log('mounted')")) { ... }
    /// ```
    ///
    /// **Notes:**
    /// Named `.setup` because `init` is a Swift keyword.
    public static func setup(_ value: String) -> HTMLAttribute {
        .init(name: "x-init", value: value)
    }
}
