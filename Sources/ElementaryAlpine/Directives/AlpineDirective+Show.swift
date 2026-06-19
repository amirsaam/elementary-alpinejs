import Elementary

/// Modifiers for the `x-show` directive.
/// See the [AlpineJS x-show modifier docs](https://alpinejs.dev/directives/show#modifiers) for the full reference.
public enum ShowModifier {
    /// `.important` — sets `display` with `!important` so the element stays visible regardless of CSS.
    case important

    var rawValue: String {
        switch self {
        case .important: "important"
        }
    }
}

extension HTMLAttribute.x {
    /// Generates an `x-show` attribute that toggles element visibility via `display: none`.
    ///
    /// - Parameters:
    ///   - value: A JavaScript expression that evaluates to a boolean.
    ///   - modifiers: Optional modifiers (e.g., `.important` to set `display: !important`).
    ///
    /// **Generated HTML:**
    /// ```html
    /// <div x-show="open">
    /// <div x-show.important="open">
    /// ```
    ///
    /// **Example:**
    /// ```swift
    /// div(.x.show("open")) { ... }
    /// div(.x.show("open", modifiers: [.important])) { ... }
    /// ```
    public static func show(_ value: String, modifiers: [ShowModifier] = []) -> HTMLAttribute {
        if modifiers.isEmpty {
            return .init(name: "x-show", value: value)
        }
        return .init(name: "x-show.\(modifiers.map(\.rawValue).joined(separator: "."))", value: value)
    }
}
