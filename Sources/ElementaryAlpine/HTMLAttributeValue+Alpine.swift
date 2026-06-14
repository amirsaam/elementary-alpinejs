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

    struct OnModifier: RawRepresentable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(event: String) {
            rawValue = event
        }
    }
}

public extension HTMLAttributeValue.Alpine.OnModifier {
    consuming func prevent() -> Self {
        appending(modifier: "prevent")
    }

    consuming func stop() -> Self {
        appending(modifier: "stop")
    }

    consuming func once() -> Self {
        appending(modifier: "once")
    }

    consuming func `self`() -> Self {
        appending(modifier: "self")
    }

    consuming func capture() -> Self {
        appending(modifier: "capture")
    }

    internal consuming func appending(modifier: String) -> Self {
        rawValue += "."
        rawValue += modifier
        return self
    }
}
