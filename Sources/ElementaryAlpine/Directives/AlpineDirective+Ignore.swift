import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-ignore` attribute that opts an element (and its subtree) out of Alpine initialization.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-ignore></div>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.ignore) { "unchanged by Alpine" }
    /// ```
    public static var ignore: HTMLAttribute {
        alpineDirective("x-ignore", value: nil)
    }
}
