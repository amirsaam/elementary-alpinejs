import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Focus plugin attributes.
    /// See the [Focus plugin docs](https://alpinejs.dev/plugins/focus) for more information.
    public enum xFocus {}
}

extension HTMLAttribute.xFocus {
    public static func trap(
        _ value: String,
        modifiers: [FocusModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-trap", value: value)
        }
        return .init(
            name: "x-trap.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }
}
