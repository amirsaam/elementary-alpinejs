import Elementary

public extension HTMLAttributeValue {
    /// A namespace for AlpineJS-specific attribute value types.
    /// See the [AlpineJS reference](https://alpinejs.dev/) for more information.
    enum Alpine {}
}

public extension HTMLAttributeValue.Alpine {
    /// A type-safe wrapper for `x-bind:class` values. The wrapped string is a JavaScript
    /// expression (object, array, or string) evaluated by Alpine.
    ///
    /// Expressible by string literal so values can be written inline:
    /// ```swift
    /// .x.bindClass("{ 'hidden': !open }")
    /// ```
    struct BindClass: RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }
    }

    /// A type-safe wrapper for `x-bind:style` values. The wrapped string is a JavaScript
    /// expression (object or string) evaluated by Alpine.
    ///
    /// Expressible by string literal so values can be written inline:
    /// ```swift
    /// .x.bindStyle("{ color: 'red' }")
    /// ```
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

extension HTMLAttribute.x {
    /// Generates an `x-bind:ATTR` attribute that binds an element attribute to a JavaScript expression.
    ///
    /// - Parameters:
    ///   - attribute: The HTML attribute name to bind (e.g., `"placeholder"`, `"src"`).
    ///   - value: A JavaScript expression whose result is assigned to the attribute.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <input x-bind:placeholder="text">
    /// <img x-bind:src="user.avatar">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// input(.x.bind("placeholder", "text"), .type(.text))
    /// img(.x.bind("src", "user.avatar"), .alt("avatar"))
    /// ```
    public static func bind(_ attribute: String, _ value: String) -> HTMLAttribute {
        .init(name: "x-bind:\(attribute)", value: value)
    }

    /// Generates a bare `x-bind` attribute (used with `Alpine.bind` globals to bind a set of attributes).
    ///
    /// - Parameter value: The name of a registered `Alpine.bind` global.
    ///
    /// **Generated HTML:**
    /// ```html
    /// <button x-bind="primaryButton">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// registerGlobal(.bind, on: "primaryButton") {
    ///     "() => ({ type: 'button', class: 'btn btn-primary' })"
    /// }
    /// button(.x.bind("primaryButton")) { "Click" }
    /// ```
    public static func bind(_ value: String) -> HTMLAttribute {
        .init(name: "x-bind", value: value)
    }

    /// Generates an `x-bind:class` attribute that sets the element's `class` reactively.
    ///
    /// - Parameter value: A `BindClass` value (built from a string or string literal).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-bind:class="{ 'hidden': !open, 'active': selected }">
    /// <div x-bind:class="'btn btn-' + variant">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.bindClass("{ 'hidden': !open, 'active': selected }"))
    /// div(.x.bindClass("'btn btn-' + variant"))
    /// ```
    public static func bindClass(_ value: HTMLAttributeValue.Alpine.BindClass) -> HTMLAttribute {
        .init(name: "x-bind:class", value: value.rawValue)
    }

    /// Generates an `x-bind:style` attribute that sets the element's inline `style` reactively.
    ///
    /// - Parameter value: A `BindStyle` value (built from a string or string literal).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-bind:style="{ color: 'red', fontSize: size + 'px' }">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.bindStyle("{ color: 'red', fontSize: size + 'px' }"))
    /// ```
    public static func bindStyle(_ value: HTMLAttributeValue.Alpine.BindStyle) -> HTMLAttribute {
        .init(name: "x-bind:style", value: value.rawValue)
    }
}
