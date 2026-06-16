import Elementary

extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    /// A namespace for AlpineJS Mask plugin attributes.
    /// See the [Mask plugin docs](https://alpinejs.dev/plugins/mask) for more information.
    public enum xMask {}
}

extension HTMLAttribute.xMask {
    public static func pattern(_ value: String) -> HTMLAttribute {
        .init(name: "x-mask", value: value)
    }

    public static func dynamic(_ value: String) -> HTMLAttribute {
        .init(name: "x-mask:dynamic", value: value)
    }
}
