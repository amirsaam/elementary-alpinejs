import Elementary

extension HTMLAttribute.x {
    /// Generates an `x-cloak` attribute that hides the element until Alpine has initialized.
    /// Pair with a CSS rule like `[x-cloak] { display: none !important; }`.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-data="{}" x-cloak></div>
    /// ```
    public static var cloak: HTMLAttribute {
        .init(name: "x-cloak", value: nil)
    }
}
