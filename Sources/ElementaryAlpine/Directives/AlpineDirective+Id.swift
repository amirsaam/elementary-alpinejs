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
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.id("['input-id']")) {
    ///     label(.x.bind("for", "$id('input-id')")) { "Name" }
    ///     input(.x.bind("id", "$id('input-id')"), .type(.text))
    /// }
    /// ```
    public static func id(_ value: String) -> HTMLAttribute {
        .init(name: "x-id", value: value)
    }
}
