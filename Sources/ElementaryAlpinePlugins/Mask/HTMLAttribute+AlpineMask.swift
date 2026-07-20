import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Mask plugin attributes.
    /// See the [Mask plugin docs](https://alpinejs.dev/plugins/mask) for more information.
    public enum xMask {}
}

extension HTMLAttribute.xMask {
    /// Generates an `x-mask` attribute that formats text input as the user types.
    ///
    /// - Parameter value: A mask pattern. Use `9` for numeric, `a` for alpha, `*` for any character.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <input x-mask="99/99/9999">
    /// <input x-mask="(999) 999-9999">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// input(.xMask.pattern("99/99/9999"), .x.model("date"))
    /// input(.xMask.pattern("(999) 999-9999"), .x.model("phone"))
    /// ```
    public static func pattern(_ value: String) -> HTMLAttribute<Tag> {
        alpinePluginDirective("x-mask", value: value)
    }

    /// Generates an `x-mask:dynamic` attribute that uses a JavaScript expression or function reference to format input.
    /// The expression receives `$input` (the current input value) as an Alpine magic.
    ///
    /// - Parameter value: A JavaScript expression (e.g., `"$money($input)"`) or a function name (e.g., `"creditCardMask"`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <input x-mask:dynamic="$money($input)">
    /// <input x-mask:dynamic="creditCardMask">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// input(.xMask.dynamic("$money($input)"), .x.model("amount"))
    /// input(.xMask.dynamic("creditCardMask"), .x.model("card"))
    /// ```
    public static func dynamic(_ value: String) -> HTMLAttribute<Tag> {
        alpinePluginDirective("x-mask:dynamic", value: value)
    }
}
