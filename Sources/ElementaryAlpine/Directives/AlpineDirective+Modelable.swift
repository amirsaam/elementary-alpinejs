import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-modelable` attribute that exposes a child component's property for two-way binding by its parent.
    ///
    /// - Parameter value: The name of the property to expose for `x-model` from the parent.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-modelable="value"></div>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.modelable("value")) { ... }
    /// ```
    public static func modelable(_ value: String) -> HTMLAttribute<Tag> {
        alpineDirective("x-modelable", value: value)
    }
}
