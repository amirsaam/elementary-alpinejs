import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Intersect plugin attributes.
    /// See the [Intersect plugin docs](https://alpinejs.dev/plugins/intersect) for more information.
    public enum xIntersect {}
}

extension HTMLAttribute.xIntersect {
    public static func intersect(
        _ value: String,
        modifiers: [IntersectModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-intersect", value: value)
        }
        return .init(
            name: "x-intersect.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }

    public static func enter(
        _ value: String,
        modifiers: [IntersectModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-intersect:enter", value: value)
        }
        return .init(
            name: "x-intersect:enter.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }

    public static func leave(
        _ value: String,
        modifiers: [IntersectModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-intersect:leave", value: value)
        }
        return .init(
            name: "x-intersect:leave.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }
}
