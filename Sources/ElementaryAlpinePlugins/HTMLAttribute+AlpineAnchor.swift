import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Anchor plugin attributes.
    /// See the [Anchor plugin docs](https://alpinejs.dev/plugins/anchor) for more information.
    public enum xAnchor {}
}

extension HTMLAttribute.xAnchor {
    public static func anchor(
        _ value: String,
        modifiers: [AnchorModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-anchor", value: value)
        }
        return .init(
            name: "x-anchor.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }
}
