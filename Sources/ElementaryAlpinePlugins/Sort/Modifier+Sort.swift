/// Modifiers for the `x-sort` directive.
/// See the [AlpineJS Sort plugin docs](https://alpinejs.dev/plugins/sort#modifiers) for the full reference.
public enum SortModifier: AlpinePluginDirectiveModifier {
    /// `.ghost` — show a ghost of the dragged element in its place (default: an empty hole).
    case ghost

    var rawValue: String {
        switch self {
        case .ghost: "ghost"
        }
    }
}
