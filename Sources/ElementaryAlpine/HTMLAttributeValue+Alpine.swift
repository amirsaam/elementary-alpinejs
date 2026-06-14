import Elementary

public extension HTMLAttributeValue {
    /// A namespace for AlpineJS attribute value types.
    /// See the [AlpineJS reference](https://alpinejs.dev/) for more information.
    enum Alpine {}
}

public extension HTMLAttributeValue.Alpine {
    struct BindClass: RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }

    struct BindStyle: RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }
}
