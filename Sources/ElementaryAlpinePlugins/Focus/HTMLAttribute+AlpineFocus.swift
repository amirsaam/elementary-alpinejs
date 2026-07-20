import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Focus plugin attributes.
    /// See the [Focus plugin docs](https://alpinejs.dev/plugins/focus) for more information.
    public enum xFocus {}
}

extension HTMLAttribute.xFocus {
    /// Generates an `x-trap` attribute that traps keyboard focus inside the element while the expression is truthy.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression that evaluates to a boolean.
    ///   - modifiers: Optional modifiers (e.g., `.inert`, `.noscroll`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-trap="open">
    /// <div x-trap.inert.noscroll="open">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.xFocus.trap("open")) { ... }
    /// div(.xFocus.trap("open", modifiers: [.inert])) { ... }
    /// div(.xFocus.trap("open", modifiers: [.inert, .noscroll, .noreturn])) { ... }
    /// ```
    public static func trap(
        _ value: String,
        modifiers: [FocusModifier] = []
    ) -> HTMLAttribute<Tag> {
        alpinePluginDirective("x-trap", modifiers: modifiers, value: value)
    }
}
