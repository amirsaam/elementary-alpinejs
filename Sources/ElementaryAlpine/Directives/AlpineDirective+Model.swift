import Elementary

/// Modifiers for the `x-model` directive.
/// See the [AlpineJS x-model modifier docs](https://alpinejs.dev/directives/model#modifiers) for the full reference.
public enum ModelModifier {
    /// `.lazy` — syncs the input on the `change` event instead of `input`.
    case lazy
    /// `.change` — alias for `.lazy`.
    case change
    /// `.blur` — syncs the input on the `blur` event instead of `input`.
    case blur
    /// `.enter` — syncs the input when the Enter key is pressed.
    case enter
    /// `.number` — coerces the input value to a number.
    case number
    /// `.boolean` — coerces the input value to a boolean.
    case boolean
    /// `.fill` — preserves `false` / `null` instead of removing the bound property.
    case fill

    var rawValue: String {
        switch self {
        case .lazy: "lazy"
        case .change: "change"
        case .blur: "blur"
        case .enter: "enter"
        case .number: "number"
        case .boolean: "boolean"
        case .fill: "fill"
        }
    }
}

extension HTMLAttribute.x {
    /// Generates an `x-model` attribute for two-way binding between an input and component state.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression identifying the state property to bind to.
    ///   - modifiers: Optional modifiers (e.g., `.lazy`, `.number`, `.debounce(300)`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <input x-model="search">
    /// <input x-model.number="age">
    /// <input x-model.lazy="form.message">
    /// <input x-model.number.debounce.300ms="query">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// input(.x.model("search"))
    /// input(.x.model("age", modifiers: [.number]))
    /// input(.x.model("query", modifiers: [.number, .debounce(300)]))
    /// ```
    public static func model(_ value: String, modifiers: [ModelModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-model", value: value)
        }
        return .init(name: "x-model.\(modifiers.map(\.rawValue).joined(separator: "."))", value: value)
    }
}
