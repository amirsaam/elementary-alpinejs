/// Modifiers for the `x-trap` directive.
/// See the [AlpineJS Focus plugin docs](https://alpinejs.dev/plugins/focus#x-trap) for the full reference.
public enum FocusModifier: AlpinePluginDirectiveModifier {
    /// `.inert` — mark other page elements `aria-hidden="true"` while focus is trapped.
    case inert
    /// `.noscroll` — block page scrolling while focus is trapped.
    case noscroll
    /// `.noreturn` — don't return focus to the previous element on untrap.
    case noreturn
    /// `.noautofocus` — don't auto-focus the first focusable element when trapping.
    case noautofocus

    var rawValue: String {
        switch self {
        case .inert: "inert"
        case .noscroll: "noscroll"
        case .noreturn: "noreturn"
        case .noautofocus: "noautofocus"
        }
    }
}
