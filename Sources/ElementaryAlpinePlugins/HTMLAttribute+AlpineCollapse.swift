import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Collapse plugin attributes.
    /// See the [Collapse plugin docs](https://alpinejs.dev/plugins/collapse) for more information.
    public enum xCollapse {}
}

extension HTMLAttribute.xCollapse {
    public static func collapse(modifiers: [CollapseModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-collapse", value: nil)
        }
        return .init(
            name: "x-collapse.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: nil
        )
    }
}
