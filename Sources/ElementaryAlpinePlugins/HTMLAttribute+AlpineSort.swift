import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Sort plugin attributes.
    /// See the [Sort plugin docs](https://alpinejs.dev/plugins/sort) for more information.
    public enum xSort {}
}

extension HTMLAttribute.xSort {
    public static func sort(
        _ value: String,
        modifiers: [SortModifier] = []
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-sort", value: value)
        }
        return .init(
            name: "x-sort.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: value
        )
    }

    public static var sort: HTMLAttribute {
        .init(name: "x-sort", value: nil)
    }

    public static func sort(
        modifiers: [SortModifier]
    ) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-sort", value: nil)
        }
        return .init(
            name: "x-sort.\(modifiers.map(\.rawValue).joined(separator: "."))",
            value: nil
        )
    }

    public static func item(_ value: String) -> HTMLAttribute {
        .init(name: "x-sort:item", value: value)
    }

    public static func group(_ value: String) -> HTMLAttribute {
        .init(name: "x-sort:group", value: value)
    }

    public static var handle: HTMLAttribute {
        .init(name: "x-sort:handle", value: nil)
    }

    public static var ignore: HTMLAttribute {
        .init(name: "x-sort:ignore", value: nil)
    }

    public static func config(_ value: String) -> HTMLAttribute {
        .init(name: "x-sort:config", value: value)
    }
}
