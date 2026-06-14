import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS attributes.
    /// See the [AlpineJS reference](https://alpinejs.dev/) for more information.
    public enum x {}
}

extension HTMLAttribute.x {
    public static func data(_ value: String) -> HTMLAttribute {
        .init(name: "x-data", value: value)
    }

    public static func `init`(_ value: String) -> HTMLAttribute {
        .init(name: "x-init", value: value)
    }
}
