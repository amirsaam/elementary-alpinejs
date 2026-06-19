/// Modifiers for the `x-collapse` directive.
/// See the [AlpineJS Collapse plugin docs](https://alpinejs.dev/plugins/collapse) for the full reference.
public enum CollapseModifier {
    /// `.duration.MSms` — animation duration in milliseconds.
    case duration(Int)
    /// `.min.Npx` — minimum collapsed height in pixels (cuts off rather than fully hides).
    case min(Int)

    var rawValue: String {
        switch self {
        case .duration(let ms): "duration.\(ms)ms"
        case .min(let px): "min.\(px)px"
        }
    }
}
