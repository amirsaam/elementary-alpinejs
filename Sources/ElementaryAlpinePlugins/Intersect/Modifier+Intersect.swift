/// Modifiers for the `x-intersect` directive.
/// See the [AlpineJS Intersect plugin docs](https://alpinejs.dev/plugins/intersect#modifiers) for the full reference.
public enum IntersectModifier {
    /// `.once` — fires the handler only the first time the element enters the viewport.
    case once
    /// `.half` — fires when at least 50% of the element is visible.
    case half
    /// `.full` — fires when 99% of the element is visible.
    case full
    /// `.threshold.N` — custom visibility threshold as a percentage (0–100).
    case threshold(Int)
    /// `.margin.CSS` — expand or contract the viewport boundary using a CSS margin string.
    case margin(String)

    var rawValue: String {
        switch self {
        case .once: "once"
        case .half: "half"
        case .full: "full"
        case .threshold(let value): "threshold.\(value)"
        case .margin(let value): "margin.\(value)"
        }
    }
}
