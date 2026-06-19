import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-id` attribute that provides an array of unique, scope-local ID keys.
    ///
    /// - Parameter value: A JavaScript array of ID keys.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-id="['input-id']"></div>
    /// ```
    public static func id(_ value: String) -> HTMLAttribute {
        .init(name: "x-id", value: value)
    }
}
