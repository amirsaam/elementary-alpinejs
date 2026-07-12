import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-ref` attribute that registers the element as a reference accessible via `$refs.NAME`.
    ///
    /// - Parameter value: The reference name (used as `$refs.value` in expressions).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <input x-ref="myInput">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// input(.x.ref("myInput"), .type(.text))
    /// button(.x.on("click", "$refs.myInput.focus()")) { "Focus" }
    /// ```
    public static func ref(_ value: String) -> HTMLAttribute {
        alpineDirective("x-ref", value: value)
    }
}
