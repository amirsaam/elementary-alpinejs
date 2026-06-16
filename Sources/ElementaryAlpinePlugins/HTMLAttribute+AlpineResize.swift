import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Resize plugin attributes.
    /// See the [Resize plugin docs](https://alpinejs.dev/plugins/resize) for more information.
    public enum xResize {}
}

extension HTMLAttribute.xResize {
    public static func resize(
        _ value: String,
        modifiers: [ResizeModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-resize", value: value)
        }
        return .init(
            name: "x-resize.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }
}
