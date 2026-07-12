import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-cloak` attribute that hides the element until Alpine has initialized.
    /// Pair with a CSS rule like `[x-cloak] { display: none !important; }`.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-data="{}" x-cloak></div>
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.data("{}"), .x.cloak) { ... }
    /// ```
    public static var cloak: HTMLAttribute {
        alpineDirective("x-cloak", value: nil)
    }
}
